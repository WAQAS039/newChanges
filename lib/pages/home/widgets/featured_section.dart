import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/featured/models/featured.dart';
import 'package:nour_al_quran/pages/featured/provider/featured_provider.dart';
import 'package:nour_al_quran/pages/featured/provider/featurevideoProvider.dart';
import 'package:nour_al_quran/pages/miracles_of_quran/models/miracles.dart';
import 'package:nour_al_quran/pages/miracles_of_quran/provider/miracles_of_quran_provider.dart';

import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:provider/provider.dart';

import '../../../shared/localization/localization_constants.dart';
import '../../bottom_tabs/provider/bottom_tabs_page_provider.dart';

import '../../quran/pages/recitation/reciter/player/player_provider.dart';
import 'home_row_widget.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    int network = Provider.of<int>(context);
    return Column(
      children: [
        HomeRowWidget(
          text: localeText(context, 'featured'),
          buttonText: localeText(context, "view_all"),
          onTap: () {
            Navigator.of(context).pushNamed(RouteHelper.featured);
          },
        ),
        Consumer<LocalizationProvider>(
          builder: (context, language, child) {
            return SizedBox(
              height: 150.h,
              child:
                  Consumer2<FeatureProvider, FeaturedMiraclesOfQuranProvider>(
                builder:
                    (context, storiesProvider, featuremiraclesProvider, child) {
                  return ListView.builder(
                    itemCount: storiesProvider.feature.length,
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 14.h),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      try {
                        FeaturedModel model = storiesProvider.feature[index];

                        return InkWell(
                          onTap: () {
                            if (network == 1) {
                              Future.delayed(
                                  Duration.zero,
                                  () => context
                                      .read<RecitationPlayerProvider>()
                                      .pause(context));
                              if (model.contentType == "audio") {
                                storiesProvider.gotoFeaturePlayerPage(
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
                                //     model.title!, context, index);
                              }
                              // storiesProvider.gotoFeaturePlayerPage(
                              //     model.storyId!, context, index);
                            } else {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text("No Internet")));
                            }
                          },
                          child: Container(
                            width: 209.w,
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/quran_feature/${model.image!}"),
                                    fit: BoxFit.cover)),
                            child: Container(
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
                                margin: EdgeInsets.only(
                                    left: 6.w, bottom: 8.h, right: 6.w),
                                alignment:
                                    language.locale.languageCode == "ur" ||
                                            language.locale.languageCode == "ar"
                                        ? Alignment.bottomRight
                                        : Alignment.bottomLeft,
                                child: Text(
                                  localeText(context, model.storyTitle!),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontFamily: "satoshi",
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        );
                      } catch (error) {
                        print("Error: $error");
                        return Container(); // Placeholder for error handling
                      }
                    },
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
