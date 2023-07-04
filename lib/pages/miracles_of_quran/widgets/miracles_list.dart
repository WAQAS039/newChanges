import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../shared/localization/localization_constants.dart';
import '../provider/miracles_of_quran_provider.dart';
import '../models/miracles.dart';

class MiraclesList extends StatelessWidget {
  const MiraclesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    return Consumer<MiraclesOfQuranProvider>(
      builder: (context, miraclesProvider, child) {
        return miraclesProvider.miracles.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.only(left: 10.w, right: 0.w),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: miraclesProvider.miracles.length,
                itemBuilder: (context, index) {
                  Miracles model = miraclesProvider.miracles[index];
                  return InkWell(
                    onTap: () {
                      miraclesProvider.goToMiracleDetailsPage(
                          model.title!, context, index);
                      analytics.logEvent(
                        name: 'model_title_tapped',
                        parameters: {'title': model.title},
                      );
                    },
                    child: Container(
                      height: 149.h,
                      margin: EdgeInsets.only(right: 9.w, bottom: 9.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: DecorationImage(
                              image: AssetImage(model.image!),
                              fit: BoxFit.cover)),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0),
                              Color.fromRGBO(0, 0, 0, 1),
                            ],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 6.w, bottom: 8.h),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            localeText(context, model.title!.toLowerCase()),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontFamily: "satoshi",
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
