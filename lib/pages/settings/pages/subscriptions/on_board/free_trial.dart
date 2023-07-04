import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/profile/profile_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/widgets/app_bar.dart';
import 'all_offers.dart';

class FreeTrial extends StatelessWidget {
  const FreeTrial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style16 = TextStyle(
        fontFamily: 'satoshi',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600
    );
    var style12 = TextStyle(
        fontFamily: 'satoshi',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400
    );
    var appColors = context.read<AppColorsProvider>().mainBrandingColor;
    return Scaffold(
      appBar: buildAppBar(context: context,title: "How your free trial works"),
      body: Container(
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8.w,top: 30.h,bottom: 30.h),
                  padding: EdgeInsets.only(bottom: 27.h),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFF097E3B).withOpacity(1),
                            const Color(0xFF097E3B).withOpacity(0),
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter
                      ),
                      borderRadius: BorderRadius.circular(12.5.r)
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 3.w,right: 3.w,top: 7.58.h,),
                        decoration: BoxDecoration(
                            color: appColors,
                            borderRadius: BorderRadius.circular(12.5.r)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 7.58.h),
                                child: const Icon(Icons.lock_open)),
                            Container(
                                margin: EdgeInsets.only(top: 60.h,),
                                child: const Icon(Icons.notifications)),
                            Container(
                                margin: EdgeInsets.only(top: 60.h,bottom: 27.h),
                                child: const Icon(Icons.star)),
                          ],
                        ),
                      ),
                      Container(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 8.w,top: 34.h,bottom: 30.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Today',style: style16,),
                      Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          margin: EdgeInsets.only(top: 3.h,bottom: 30.h),
                          child: Text('Start your full access to all the sections of App.',style: style12,)),
                      Text('Day 5',style: style16,),
                      Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          margin: EdgeInsets.only(top: 3.h,bottom: 30.h),
                          child: Text('You will get a reminder about when your trial will end',style: style12,)),
                      Text('Day 7',style: style16,),
                      Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          margin: EdgeInsets.only(top: 3.h,bottom: 30.h),
                          child: Text('You will be charged. Cancel anytime before this.',style: style12,)),
                    ],
                  ),
                ),
              ],
            ),
            Text("Unlimited free access for 7 days, then US \$15.49 per year (US \$1.29 per month)",style: TextStyle(
              fontFamily: 'satoshi',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400
            ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h,),
            TextButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const AllOffers(),));
                },
                child: Text("View All Plans",style: TextStyle(
                    fontFamily: 'satoshi',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors
                ),),),
            const Spacer(),
            BrandButton(text: "Start my free trial", onTap: () async{
              var loginStatus = Hive.box(appBoxKey).get(loginStatusString) ?? 0;
              Provider.of<ProfileProvider>(context,listen: false).setFromWhere("fromInApp");
              if(loginStatus != 0){
                await showInAppBottonSheet(context);
              }else{
                var result = await Navigator.of(context).pushNamed(RouteHelper.signIn);
                Fluttertoast.showToast(msg: result.toString());
                if(result == "login"){
                  Future.delayed(Duration.zero,() async{
                    await showInAppBottonSheet(context);
                  });
                }
              }
            }),
            Text("Unlimited Access for 15 days",style: TextStyle(
                fontFamily: 'satoshi',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: appColors
            ),),
          ],
        ),
      ),
    );
  }

  Future<void> showInAppBottonSheet(BuildContext context) async {
     await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Center(child: Text("In App Purchase"),);
        },);
  }
}
