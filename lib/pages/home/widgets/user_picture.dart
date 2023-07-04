import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../shared/localization/localization_constants.dart';
import '../../../shared/routes/routes_helper.dart';
import '../../../shared/utills/app_constants.dart';
import '../../../shared/widgets/circle_button.dart';
import '../../settings/pages/app_colors/app_colors_provider.dart';
import '../../settings/pages/profile/profile_provider.dart';

class UserPicture extends StatelessWidget {
  const UserPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(left: 20.w, top: 60.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localeText(context, 'home'),
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontFamily: "satoshi",
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Consumer<AppColorsProvider>(
                    builder: (context, appColors, child) {
                      return Text(
                        HijriCalendar.now().toFormat("dd MMMM yyyy"),
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "satoshi",
                            color: appColors.mainBrandingColor),
                      );
                    },
                  ),
                ],
              )),
          InkWell(
            onTap: () {
              var loginStatus = Hive.box(appBoxKey).get(loginStatusString) ?? 0;
              Provider.of<ProfileProvider>(context, listen: false)
                  .setFromWhere("home");
              Navigator.of(context).pushNamed(loginStatus != 0
                  ? RouteHelper.manageProfile
                  : RouteHelper.signIn);
            },
            child: Container(
                margin: EdgeInsets.only(
                  top: 61.h,
                  right: 20.w,
                  left: 20.w,
                ),
                child: CircleButton(
                    height: 29.h,
                    width: 29.w,
                    icon: FirebaseAuth.instance.currentUser != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: Consumer<ProfileProvider>(
                              builder: (context, profile, child) {
                                return profile.userProfile != null
                                    ? profile.userProfile!.image != ""
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                profile.userProfile!.image!,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.person),
                                          )
                                        : CircleButton(
                                            height: 29.h,
                                            width: 29.w,
                                            icon: const Icon(Icons.person))
                                    : CircleButton(
                                        height: 29.h,
                                        width: 29.w,
                                        icon: const Icon(Icons.person));
                              },
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 11.h,
                            color: Colors.white,
                          ))),
          ),
        ],
      ),
    );
  }
}
