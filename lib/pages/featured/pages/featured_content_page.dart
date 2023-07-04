import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nour_al_quran/pages/featured/provider/featured_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/circle_button.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_bar.dart';

class FeaturedDetailsPage extends StatelessWidget {
  const FeaturedDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontProvider fontProvider = Provider.of<FontProvider>(context);
    return Consumer2<FeatureProvider, AppColorsProvider>(
      builder: (context, story, appColors, child) {
        return Scaffold(
          appBar: buildAppBar(
              context: context,
              title:
                  localeText(context, story.selectedFeatureStory!.storyTitle!)),
          body: story.selectedFeatureStory!.text != null
              ? SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 16.h, bottom: 16.h),
                    child: story.selectedFeatureStory!.text != null
                        ? HtmlWidget(
                            story.selectedFeatureStory!.text!,
                            textStyle: TextStyle(
                              fontFamily: 'satoshi',
                              fontSize: fontProvider.fontSizeTranslation.sp,
                            ),

                            /// pending means data not added in db by data entry person
                          )
                        : const Center(
                            child: Text('pending'),
                          ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
