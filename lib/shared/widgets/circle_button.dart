import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:provider/provider.dart';

class CircleButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget icon;
  final bool isLoading;

  const CircleButton({
    Key? key,
    required this.height,
    required this.width,
    required this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Consumer<AppColorsProvider>(
        builder: (context, value, child) {
          return CircleAvatar(
            backgroundColor: value.mainBrandingColor,
            child: icon,
          );
        },
      ),
    );
  }
}
