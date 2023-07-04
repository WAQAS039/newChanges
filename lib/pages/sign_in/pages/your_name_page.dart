import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/sign_in/provider/sign_in_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

class YourNamePage extends StatefulWidget {
  const YourNamePage({Key? key}) : super(key: key);

  @override
  State<YourNamePage> createState() => _YourNamePageState();
}

class _YourNamePageState extends State<YourNamePage> {
  var name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20.w,right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 4.h,top: 25.h),
                child: Text("What’s your email address?",style: TextStyle(
                    fontFamily: "satoshi",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900
                ),),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.h,),
                child: Text("Let’s get started on the Al-Quran App",style: TextStyle(
                    fontFamily: 'satoshi',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey2
                ),),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 5.h),
                      child: const Text('Your Name')),
                  Container(
                      alignment: Alignment.center,
                      height: 46.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: AppColors.grey5)
                      ),
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Enter Your Name",
                            contentPadding: EdgeInsets.only(left: 10.w,right: 10.w),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none
                        ),
                      )
                  ),
                ],
              ),
              const Spacer(),
              BrandButton(text: "Continue", onTap: (){
                List<String> arguments = ModalRoute.of(context)!.settings.arguments as List<String>;
                Provider.of<SignInProvider>(context,listen: false).signUpWithEmailPassword(arguments[0], arguments[1],name.text,context);
              }),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }
}
