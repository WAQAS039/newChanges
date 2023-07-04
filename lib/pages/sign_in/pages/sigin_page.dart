import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/sign_in/provider/sign_in_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:nour_al_quran/shared/widgets/text_field_column.dart';
import 'package:provider/provider.dart';

import '../../../shared/utills/app_constants.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Provider.of<AppColorsProvider>(context, listen: false)
        .mainBrandingColor;
    Icon closeIcon = const Icon(Icons.close);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
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
                      margin: EdgeInsets.only(
                        bottom: 16.h,
                        top: 25.h,
                      ),
                      child: Text(
                        localeText(context, "login_to_get_started"),
                        style: TextStyle(
                            fontFamily: "satoshi",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldColumn(
                            titleText: localeText(context, "enter_your_email"),
                            controller: email,
                            hintText: localeText(context, "enter_your_email"),
                            isPasswordField: false,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFieldColumn(
                            titleText: localeText(context, 'password'),
                            controller: password,
                            hintText: localeText(context, 'password'),
                            isPasswordField: true,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 13.h, bottom: 20.h),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteHelper.forgetPassword);
                              },
                              child: Text(
                                localeText(context, "forgot_password"),
                                style: TextStyle(
                                    fontFamily: 'satoshi',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.sp,
                                    color: AppColors.mainBrandingColor),
                              ),
                            ),
                          ),
                          BrandButton(
                            text: localeText(context, "login"),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Provider.of<SignInProvider>(context,
                                        listen: false)
                                    .signInWithEmailPassword(
                                        email.text, password.text, context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.h),
                      width: double.maxFinite,
                      child: Text(
                        localeText(context, 'or_login_using'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'satoshi',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.h, bottom: 30.h),
                      child: Row(
                        children: [
                          _buildThirdPartyLoginContainers('google', () async {
                            context
                                .read<SignInProvider>()
                                .signInWithGoogle(context);
                          }),
                          Platform.isIOS
                              ? _buildThirdPartyLoginContainers('apple', () {
                                  context
                                      .read<SignInProvider>()
                                      .signInWithApple();
                                })
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                    buildRegisterOrHaveAccountContainer(
                      title:
                          localeText(context, "don't_have_an_account_register"),
                      onPress: () {
                        Navigator.of(context).pushNamed(RouteHelper.signUp);
                      },
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Hive.box(appBoxKey).put(onBoardingDoneKey, "done");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteHelper.application,
                    (route) => false,
                  );
                },
                icon: closeIcon,
              ),
            ),
          ],
        ),
      ),
    );
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
            borderRadius: BorderRadius.circular(6.r),
          ),
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

Widget buildRegisterOrHaveAccountContainer({
  required String title,
  required VoidCallback onPress,
  required BuildContext context,
}) {
  Color color =
      Provider.of<AppColorsProvider>(context, listen: false).mainBrandingColor;
  return InkWell(
    onTap: onPress,
    child: Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 16.h, bottom: 15.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
          fontFamily: 'satoshi',
        ),
      ),
    ),
  );
}
