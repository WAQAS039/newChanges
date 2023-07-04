import 'dart:async';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'location_error_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'provider.dart';
import '../../../settings/pages/app_colors/app_colors_provider.dart';
import '../../../settings/pages/app_them/them_provider.dart';

import '../../../../shared/utills/app_colors.dart';

import 'package:provider/provider.dart';

class QiblahMaps extends StatefulWidget {
  static const makkahLatLong = LatLng(21.422487, 39.826206);
  final makkahMarker = Marker(
    markerId: const MarkerId("mecca"),
    position: makkahLatLong,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    draggable: false,
  );

  QiblahMaps({super.key});

  @override
  _QiblahMapsState createState() => _QiblahMapsState();
}

class _QiblahMapsState extends State<QiblahMaps> {
  Uint8List? markerImage;
  List<String> images = [
    'assets/images/app_icons/qibla_marker.png',
  ];
  List<String> images2 = [
    'assets/images/app_icons/location_marker.png',
  ];
  final Completer<GoogleMapController> _controller = Completer();
  LatLng position = const LatLng(36.800636, 10.180358);

  Future<Position?>? _future;
  final _positionStream = StreamController<LatLng>.broadcast();
  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    _future = _checkLocationStatus();
    super.initState();
    loadData();
    // loadData2();
  }

  @override
  void dispose() {
    _positionStream.close();
    super.dispose();
  }

  final List<Marker> _markers = <Marker>[];
  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: QiblahMaps.makkahLatLong,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        onTap: _updateCamera,
        onDragEnd: (LatLng value) {
          position = value;
          _positionStream.sink.add(value);
        },
        zIndex: 5,
      ));
    }
  }

  // loadData2() async {
  //   for (int i = 0; i < images2.length; i++) {
  //     final Uint8List markerIcon = await getBytesFromAssets(images2[i], 150);
  //     _markers.add(Marker(
  //       markerId: MarkerId(i.toString()),
  //       position: position,
  //       icon: BitmapDescriptor.fromBytes(markerIcon),
  //       onTap: _updateCamera,
  //       onDragEnd: (LatLng value) {
  //         position = value;
  //         _positionStream.sink.add(value);
  //       },
  //       zIndex: 5,
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer3<QiblaProvider, AppColorsProvider, ThemProvider>(
            builder: (context, qibla, appColors, them, child) {
      return FutureBuilder(
        future: _future,
        builder: (_, AsyncSnapshot<Position?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                margin: EdgeInsets.all(20.h),
                child: Center(
                  child: CircularProgressIndicator(
                    color: them.isDark
                        ? Colors.white
                        : appColors.mainBrandingColor,
                  ),
                ));
          }
          if (snapshot.hasError) {
            return LocationErrorWidget(
              error: snapshot.error.toString(),
            );
          }

          if (snapshot.data != null) {
            // loadData2();
            final loc =
                LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
            position = loc;
          } else {
            _positionStream.sink.add(position);
          }

          return StreamBuilder(
            stream: _positionStream.stream,
            builder: (_, AsyncSnapshot<LatLng> snapshot) => Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: position,
                      zoom: 2,
                    ),
                    markers: Set<Marker>.of(_markers),
                    circles: <Circle>{
                      Circle(
                        circleId: const CircleId("Circle"),
                        radius: 10,
                        center: position,
                        fillColor: AppColors.mainBrandingColor.withAlpha(100),
                        strokeWidth: 1,
                        strokeColor: AppColors.mainBrandingColor.withAlpha(100),
                        zIndex: 3,
                      )
                    },
                    polylines: <Polyline>{
                      Polyline(
                        polylineId: const PolylineId("Line"),
                        points: [position, QiblahMaps.makkahLatLong],
                        color: AppColors.mainBrandingColor,
                        width: 2,
                        zIndex: 4,
                        patterns: <PatternItem>[
                          PatternItem.dash(20),
                          PatternItem.gap(10),
                        ],
                      )
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }));
  }

  Future<Position?> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled) {
      return await Geolocator.getCurrentPosition();
    }
    return null;
  }

  void _updateCamera() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 20));
  }
}
