import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../shared/localization/localization_constants.dart';
import '../../quran/pages/recitation/reciter/player/player_provider.dart';
import '../provider/islam_basics_provider.dart';
import '../models/islam_basics.dart';

class IslamBasicList extends StatelessWidget {
  const IslamBasicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int network = Provider.of<int>(context);
    return Consumer<IslamBasicsProvider>(
      builder: (context, islamBasicProvider, child) {
        return islamBasicProvider.islamBasics.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.only(left: 10.w, right: 0.w),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: islamBasicProvider.islamBasics.length,
                itemBuilder: (context, index) {
                  IslamBasics model = islamBasicProvider.islamBasics[index];
                  return InkWell(
                    onTap: () async {
                      if (network == 1) {
                        Future.delayed(
                            Duration.zero,
                            () => context
                                .read<RecitationPlayerProvider>()
                                .pause(context));
                        islamBasicProvider.gotoBasicsPlayerPage(
                            model.title!, context, index);
                      } else {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                              const SnackBar(content: Text("No Internet")));
                      }
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
