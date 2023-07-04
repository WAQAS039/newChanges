import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/featured/models/featured.dart';
import 'package:nour_al_quran/pages/featured/provider/featured_provider.dart';
import 'package:nour_al_quran/pages/featured/provider/featurevideoProvider.dart';
import 'package:nour_al_quran/pages/miracles_of_quran/provider/miracles_of_quran_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/localization/localization_constants.dart';
import '../../quran/pages/recitation/reciter/player/player_provider.dart';

class FeaturedList extends StatelessWidget {
  const FeaturedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int network = Provider.of<int>(context);
    return Expanded(
      child: Consumer2<FeatureProvider, FeaturedMiraclesOfQuranProvider>(
        builder: (context, featureProvider, featuremiraclesProvider, child) {
          return featureProvider.feature.isNotEmpty
              ? GridView.builder(
                  padding: EdgeInsets.only(left: 10.w, right: 0.w),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: featureProvider.feature.length,
                  itemBuilder: (context, index) {
                    FeaturedModel model = featureProvider.feature[index];
                    return InkWell(
                      onTap: () {
                        if (network == 1) {
                          /// if recitation player is on So this line is used to pause the player
                          Future.delayed(Duration.zero, () => context.read<RecitationPlayerProvider>().pause(context));
                          if (model.contentType == "audio") {
                            featureProvider.gotoFeaturePlayerPage(
                                model.storyId!, context, index);
                          } else if (model.contentType == "Video") {
                            print(index);
                            print(model.storyTitle!);
                            /// two ways without creating any separate provider
                            /// directly using MiraclesOfQuranProvider
                            Provider.of<MiraclesOfQuranProvider>(context,listen: false)
                                .goToMiracleDetailsPageFromFeatured(model.storyTitle!, context, index);
                            /// else u can use your own provider as u create both work fine u can check and give me some
                            /// feedback tomorrow
                            /// u can un comment this and commit out MiraclesOfQuranProvider this provider line to check both
                            // featuremiraclesProvider.goToMiracleDetailsPage(
                            //     model.storyTitle!, context, index);
                          }
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
                                image: AssetImage(
                                    "assets/images/quran_feature/${model.image!}"),
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
                            margin: EdgeInsets.only(
                                left: 6.w, bottom: 8.h, right: 9.w),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              localeText(
                                  context, model.storyTitle!.toLowerCase()),
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
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
        },
      ),
    );
  }
}
