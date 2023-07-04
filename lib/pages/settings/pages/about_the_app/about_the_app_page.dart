import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';

import '../../../../shared/widgets/app_bar.dart';

class AboutTheAppPage extends StatelessWidget {
  const AboutTheAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context, "about_the_app")),
      body: Container(
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Column(
          children: [
            Container(
              height: 116.h,
              width: 116.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                image: DecorationImage(
                  image: Image.asset('assets/images/splash/icon.png').image
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25.h,bottom: 25.h),
              child: Text("Lorem ipsum dolor sit amet consectetur. Penatibus felis tortor tortor semper "
                  "condimentum. Nunc dolor scelerisque non in turpis non malesuada. "
                  "Vitae commodo eget duis tempus placerat tincidunt dictumst tincidunt sollicitudin. Aliquet consectetur gravida "
                  "dolor at integer turpis non elementum. Quisque urna volutpat ac praesent ac euismod aliquet netus. "
                  "Porttitor tincidunt et odio in sit facilisis consequat. Neque nulla enim cursus maecenas fermentum enim. "
                  "Erat et ut nec lorem cursus. Venenatis sed sociis vulputate non ultrices eget lorem donec. "
                  "Nec pellentesque sed amet vitae purus. Amet sit vulputate non in consequat ornare aliquet. "
                  "A morbi sed platea augue tempus. Elit porttitor non etiam aliquam lobortis mauris eu lobortis diam. A eros at faucibus posuere.",
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              alignment: Alignment.centerLeft,
              child: Text('Developers',style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'satoshi',
                fontWeight: FontWeight.w500
              ),),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text("CANZ Studios",style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'satoshi',
                    fontWeight: FontWeight.w700
                )))
          ],
        ),
      ),
    );
  }
}
