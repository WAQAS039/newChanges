import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/profile/profile_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class EditProfilepage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilepage> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var name = TextEditingController();
  var password = TextEditingController();
  bool isHide = true;

  @override
  void initState() {
    super.initState();
    name.text = Provider.of<ProfileProvider>(context, listen: false)
            .userProfile!
            .fullName ??
        "";
    email.text = Provider.of<ProfileProvider>(context, listen: false)
            .userProfile!
            .email ??
        "";
    password.text = "";
  }

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var them = context.read<ThemProvider>().isDark;
    var style14 = TextStyle(
        fontFamily: 'satoshi',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: them ? AppColors.grey4 : AppColors.grey2);
    var style = TextStyle(
      fontFamily: 'satoshi',
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
    return Scaffold(
      appBar: buildAppBar(
          context: context, title: localeText(context, 'edit_profile')),
      body: SingleChildScrollView(
        child: Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            return Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localeText(context, 'full_name'),
                      style: style14,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.h),
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: AppColors.grey5)),
                      child: TextFormField(
                        controller: name,
                        style: style,
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localeText(context, 'email_address'),
                      style: style14,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.h),
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: AppColors.grey5)),
                      child: TextFormField(
                          controller: email,
                          readOnly: profile.userProfile!.loginType ==
                                      "google" ||
                                  profile.userProfile!.loginType == "facebook"
                              ? true
                              : false,
                          style: style,
                          decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none)),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Password',
                      style: style14,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.h),
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: AppColors.grey5)),
                      child: TextFormField(
                        obscureText: isHide,
                        style: style,
                        controller: password,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isHide = !isHide;
                                });
                              },
                              icon: Icon(isHide
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        ),
                        onSaved: (value) {},
                      ),
                    ),
                    // Text(
                    //   'Preferred App Language',
                    // ),
                    // DropdownButtonFormField<String>(
                    //   value: _appLanguages[0],
                    //   onChanged: (value) {},
                    //   items: _appLanguages
                    //       .map((language) => DropdownMenuItem(
                    //     value: language,
                    //     child: Text(language),
                    //   ))
                    //       .toList(),
                    // ),
                    SizedBox(height: 16.h),
                    BrandButton(
                        text: localeText(context, 'update_profile'),
                        onTap: () {
                          profile.updateProfile(
                              name.text, email.text, password.text);
                          // Navigator.of(context).pushReplacementNamed(RouteHelper.manageProfile);
                        }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
