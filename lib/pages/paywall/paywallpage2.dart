import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/app_bar.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import '../../../../../shared/routes/routes_helper.dart';
import '../../../../../shared/localization/localization_constants.dart';
import '../../../../../shared/widgets/title_row.dart';
import 'package:provider/provider.dart';

class paywallpage2 extends StatelessWidget {
  const paywallpage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildpaywallappbar(
          context: context,
          title: localeText(context, "how_your_free_trial_works"),
          icon: ""),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30.w,
                  height: 290.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.darkBrandingColor
                            .withOpacity(0.1), // Full opacity color
                        AppColors.darkBrandingColor
                            .withOpacity(1.0), // Transparent color
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors
                        .darkBrandingColor, // Adjust the value as needed
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors
                              .mainBrandingColor, // Adjust the value as needed
                        ),
                        width: 30.w,
                        height: 220.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: SvgPicture.asset(
                                'assets/images/app_icons/Lock.svg',
                                // Replace with the desired icon
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              child: SvgPicture.asset(
                                'assets/images/app_icons/Bell.svg',
                                // Replace with the desired icon
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              child: SvgPicture.asset(
                                'assets/images/app_icons/Star_White.svg',
                                // Replace with the desired icon
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: fetchPaywallData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        final perYearPrice = data['price'];
                        final perMonthPrice = data['perMonthPrice'];
                        return Container(
                          width: double.infinity,
                          height: 120.h,
                          child: Column(
                            children: [
                              Text(
                                'Unlimited free access for 7 days, then $perYearPrice per year ($perMonthPrice )',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'satoshi',
                                  fontSize: 15.sp,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'View All Plans',
                                      style: TextStyle(
                                        color: AppColors.mainBrandingColor,
                                        fontFamily: 'satoshi',
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Error retrieving data');
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 65.h,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Today',
                          style: TextStyle(
                            fontFamily: 'satoshi',
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Start your full access to all the sections of the App.',
                            style: TextStyle(
                              fontFamily: 'satoshi',
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: Container(
                    height: 65.h,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Day 5',
                            style: TextStyle(
                              fontFamily: 'satoshi',
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'You will get a reminder about when your trial will end.',
                              style: TextStyle(
                                fontFamily: 'satoshi',
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Container(
                    height: 60,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Day 7',
                            style: TextStyle(
                              fontFamily: 'satoshi',
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'You will be charged.Cancel anytime before this.',
                              style: TextStyle(
                                fontFamily: 'satoshi',
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  child: BrandButton(
                      text: localeText(context, "start_free_trial"),
                      onTap: () {
                        Navigator.of(context).pushNamed(RouteHelper.signIn);
                      }),
                ),

                // Handle button 1 press

                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                      localeText(
                        context, "unlimted_access_for_15_days",

                        // Navigator.of(context)
                        //     .pushNamed(RouteHelper.paywallscreen2);
                      ),
                      style: TextStyle(
                          color: AppColors.mainBrandingColor,
                          fontFamily: 'satoshi',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<DocumentSnapshot> fetchPaywallData() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('paywalldata')
      .doc(
          'giHi8IY0OaCGvLpfITpQ') // Replace 'DOCUMENT_ID' with the ID of the document you want to retrieve data from
      .get();
  return snapshot;
}
