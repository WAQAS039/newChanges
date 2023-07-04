import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/sign_in/pages/sigin_page.dart';
import 'package:nour_al_quran/pages/sign_in/provider/sign_in_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:nour_al_quran/shared/widgets/text_field_column.dart';
import 'package:provider/provider.dart';

import '../../../shared/utills/app_constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Icon closeIcon = const Icon(Icons.close);
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 14.h, top: 25.h),
                  child: Text(
                    localeText(
                        context, "create_an_account_to_save_your_progress"),
                    style: TextStyle(
                        fontFamily: "satoshi",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 15.h,
                  ),
                  child: Text(
                    localeText(
                        context, "let's_get_started_on_the_quran_pro_app"),
                    style: TextStyle(
                        fontFamily: 'satoshi',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey2),
                  ),
                ),
                TextFieldColumn(
                    titleText: localeText(context, "enter_your_email"),
                    controller: email,
                    hintText: localeText(context, "enter_your_email")),
                SizedBox(
                  height: 10.h,
                ),
                TextFieldColumn(
                  titleText: localeText(context, "password"),
                  controller: password,
                  hintText: localeText(context, "password"),
                  isPasswordField: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                BrandButton(
                    text: localeText(context, "register"),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteHelper.yourName,
                          arguments: [email.text, password.text]);
                    }),
                Container(
                    margin: EdgeInsets.only(top: 16.h),
                    width: double.maxFinite,
                    child: Text(
                      localeText(context, 'or_register_using'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'satoshi',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 30.h),
                  child: Row(children: [
                    // _buildThirdPartyLoginContainers('facebook', () {
                    //   context
                    //       .read<SignInProvider>()
                    //       .signInWithFaceBook(context);
                    // }),
                    _buildThirdPartyLoginContainers('google', () async {
                      context.read<SignInProvider>().signInWithGoogle(context);
                    }),
                    Platform.isIOS
                        ? _buildThirdPartyLoginContainers('apple', () {
                            context.read<SignInProvider>().signInWithApple();
                          })
                        : const SizedBox.shrink(),
                  ]),
                ),
                buildRegisterOrHaveAccountContainer(
                    title: localeText(
                        context, "already_have_account_an_account_login"),
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                    context: context)
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              // Handle close button press
              Hive.box(appBoxKey).put(onBoardingDoneKey, "done");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteHelper.application, (route) => false);
            },
            icon: closeIcon,
          ),
        ),
      ]),
    ));
  }

  Widget _buildThirdPartyLoginContainers(String loginType, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 46.h,
          margin: EdgeInsets.only(right: 12.w),
          padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
          decoration: BoxDecoration(
              color: loginType == "facebook"
                  ? AppColors.facebookColor
                  : loginType == "google"
                      ? AppColors.googleColor
                      : Colors.black,
              borderRadius: BorderRadius.circular(6.r)),
          child: Image.asset(
            'assets/images/app_icons/$loginType.png',
            height: 20.h,
            width: 20.w,
          ),
        ),
      ),
    );
  }
}
