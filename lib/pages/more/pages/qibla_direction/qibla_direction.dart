import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/more/pages/qibla_direction/provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utills/dimensions.dart';
import '../../../../shared/widgets/app_bar.dart';
import 'qibla_direction_map.dart';

class QiblaDirectionPage extends StatefulWidget {
  const QiblaDirectionPage({Key? key}) : super(key: key);

  @override
  State<QiblaDirectionPage> createState() => _QiblaDirectionPageState();
}

class _QiblaDirectionPageState extends State<QiblaDirectionPage>
    with SingleTickerProviderStateMixin {
  bool _showList = true;
  bool _showDistanceData = false;
  int? degree;

  List<String> compassImages = [
    'assets/images/app_icons/qibla_campass.png',
    'assets/images/app_icons/compass_design_4.png',
    'assets/images/app_icons/compass_design_1.png',
    'assets/images/app_icons/compass_design_2.png',
    'assets/images/app_icons/compass_design_3.png',
  ];
  int selectedImageIndex = 0;
  ScrollController scrollController = ScrollController();

  bool mapsButtonClicked = false;
  Color _qiblabutton = AppColors.mainBrandingColor;
  Color _arrowbutton = Colors.white;
  Color _mapbutton = Colors.white;
  String _imagePath = 'assets/images/app_icons/qibla_campass.png';

  bool _showCustomWidget = false;
  void _showArrowimage(Color mainBrandingColor) {
    setState(() {
      _showDistanceData = true;
      _showList = false;
      _showCustomWidget = false;
      _qiblabutton = Colors.white;
      _arrowbutton = mainBrandingColor;
      _mapbutton = Colors.white;
      _imagePath = 'assets/images/app_icons/qiblaa_arrow.png';
    });
  }

  void _showQiblaImage(Color mainBrandingColor) {
    setState(() {
      _showDistanceData = false;
      _showList = true;
      _showCustomWidget = false;
      _qiblabutton = mainBrandingColor;
      _arrowbutton = Colors.white;
      _mapbutton = Colors.white;
      _imagePath = 'assets/images/app_icons/qibla_campass.png';
    });
  }

  void _showCustomWidgetFunction(Color mainBrandingColor) {
    setState(() {
      _showDistanceData = true;
      _showList = false;
      _qiblabutton = Colors.white;
      _arrowbutton = Colors.white;
      _mapbutton = mainBrandingColor;
      _showCustomWidget = true;
    });
  }

  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;
  StreamSubscription<QiblahDirection>? _qiblahStreamSubscription;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
    _qiblabutton = AppColorsProvider().mainBrandingColor;
    _qiblahStreamSubscription =
        FlutterQiblah.qiblahStream.listen((QiblahDirection direction) {
      setState(() {
        degree = direction.offset.toInt();
      });
    });
  }

  @override
  dispose() {
    _animationController!.dispose();
    FlutterQiblah().dispose();
    _qiblahStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showdegree(
          context: context,
          title: localeText(context, "qibla_degrees"),
          degree: "${degree?.toString()}°"),
      body: Consumer3<QiblaProvider, AppColorsProvider, ThemProvider>(
        builder: (context, qibla, appColors, them, child) {
          var textStyle = TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'satoshi',
              fontSize: 14.sp,
              color: them.isDark ? AppColors.grey6 : AppColors.grey2);
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 20.w, left: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
                    decoration: BoxDecoration(
                        color: them.isDark ? AppColors.darkColor : Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 15,
                              color: Color.fromRGBO(0, 0, 0, 0.08))
                        ]),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 17.w, right: 22.w),
                            child: Image.asset(
                              'assets/images/app_icons/send.png',
                              height: 15.h,
                              width: 15.h,
                              color: appColors.mainBrandingColor,
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Dimensions.width < 330
                                  ? qibla.address.substring(
                                      0,
                                      qibla.address.contains(",")
                                          ? qibla.address.indexOf(",")
                                          : 15)
                                  : qibla.address,
                              style: TextStyle(
                                color: them.isDark
                                    ? AppColors.grey6
                                    : AppColors.grey2,
                                fontFamily: 'satoshi',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              localeText(context, 'your_current_location'),
                              style: TextStyle(
                                  color: them.isDark
                                      ? AppColors.grey5
                                      : AppColors.grey3,
                                  fontFamily: 'satoshi',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

//compass , arrow , google map code
                  Container(
                    height: 60.h, // Set height of the tab buttons
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () =>
                                  _showQiblaImage(appColors.mainBrandingColor),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _qiblabutton,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18.r),
                                    bottomLeft: Radius.circular(18.r),
                                  ),
                                  side: BorderSide(
                                      color: appColors.mainBrandingColor),
                                ),
                              ),
                              child: Text(
                                localeText(
                                  context,
                                  "compass",
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'satoshi',
                                  fontSize: 14.sp,
                                ),
                              )),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () =>
                                  _showArrowimage(appColors.mainBrandingColor),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _arrowbutton,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(
                                      color: appColors.mainBrandingColor),
                                ),
                              ),
                              child: Text(
                                localeText(
                                  context,
                                  "arrow",
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'satoshi',
                                  fontSize: 14.sp,
                                ),
                              )),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () => _showCustomWidgetFunction(
                                  appColors.mainBrandingColor),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _mapbutton,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(18.r),
                                    topRight: Radius.circular(18.r),
                                  ),
                                  side: BorderSide(
                                      color: appColors.mainBrandingColor),
                                ),
                              ),
                              child: Text(
                                localeText(
                                  context,
                                  "map",
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'satoshi',
                                  fontSize: 14.sp,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  StreamBuilder(
                      stream: FlutterQiblah.qiblahStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final qiblaDirection = snapshot.data;
                          int degree = qiblaDirection!.offset.toInt();
                          animation = Tween(
                                  begin: begin,
                                  end:
                                      (qiblaDirection.qiblah) * (pi / 180) * -1)
                              .animate(_animationController!);
                          begin = (qiblaDirection.qiblah * (pi / 180) * -1);
                          _animationController!.forward(from: 0);
                          return Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(top: 40.h, bottom: 10.h),
                                child: _showCustomWidget
                                    ? SizedBox(
                                        height: 400.h, child: QiblahMaps())
                                    : AnimatedBuilder(
                                        animation: animation!,
                                        builder: (context, child) {
                                          return Transform.rotate(
                                            angle: animation!.value,
                                            child: Image.asset(
                                              _imagePath,
                                              height: 294.h,
                                              width: 284.w,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                              Visibility(
                                visible: _showList,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: appColors.mainBrandingColor,
                                        width: 2,
                                      ),
                                    ),
                                    height: 80.h,
                                    width: 300.w,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.builder(
                                        controller: scrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: compassImages.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Image.asset(
                                                compassImages[index],
                                                width: 60,
                                                height: 60,
                                              ),
                                            ),
                                            onTap: () => (int index) {
                                              setState(() {
                                                _imagePath =
                                                    compassImages[index];
                                                //selectedImageIndex = index;
                                              });
                                            }(index),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container(
                              margin: EdgeInsets.all(20.h),
                              child: CircularProgressIndicator(
                                color: them.isDark
                                    ? Colors.white
                                    : appColors.mainBrandingColor,
                              ));
                        }
                      }),
                  Visibility(
                    visible: _showDistanceData,
                    child: Container(
                      margin: EdgeInsets.only(top: 21.h, bottom: 24.h),
                      padding: EdgeInsets.only(
                          left: 13.w, right: 13.w, top: 13.h, bottom: 12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color:
                              them.isDark ? AppColors.darkColor : Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.08))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                localeText(context, 'distance_to_qibla'),
                                style: textStyle,
                              ),
                              Text(
                                '${qibla.qiblaDistance} ${localeText(context, "km")}',
                                style: textStyle,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                localeText(context, 'longitude'),
                                style: textStyle,
                              ),
                              Text(
                                qibla.lng.toString(),
                                style: textStyle,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                localeText(context, 'latitude'),
                                style: textStyle,
                              ),
                              Text(
                                qibla.lat.toString(),
                                style: textStyle,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  // BrandButton(text: "Switch to 3D VIEW",onTap: (){},)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
