import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:provider/provider.dart';
import '../../../shared/widgets/app_bar.dart';
import '../provider/islam_basics_provider.dart';

class IslamBasicDetailsPage extends StatelessWidget {
  const IslamBasicDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontProvider fontProvider = Provider.of<FontProvider>(context);
    var islamicBasic = Provider.of<IslamBasicsProvider>(context, listen: false)
        .selectedIslamBasics;
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: localeText(context, islamicBasic!.title!.toLowerCase())),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h, bottom: 16.h),

          /// html widget will load html content from home.db
          child: HtmlWidget(
            islamicBasic.text!,
            textStyle: TextStyle(
              fontFamily: 'satoshi',
              fontSize: fontProvider.fontSizeTranslation.sp,
            ),
            customStylesBuilder: (element) {
              // Check if the element is <em>
              if (element.localName == 'strong') {
                final appColorsProvider =
                    Provider.of<AppColorsProvider>(context);
                final brandingColor = appColorsProvider.mainBrandingColor;
                final colorValue =
                    '#${brandingColor.value.toRadixString(16).substring(2)}';

                return {
                  'color': colorValue,
                }; // Apply mainBrandingColor to the text color
              }
              if (element.localName == 'em') {
                final appColorsProvider =
                    Provider.of<AppColorsProvider>(context);

                final brandingColor = appColorsProvider.mainBrandingColor;

                final colorValue =
                    '#${brandingColor.value.toRadixString(16).substring(2)}';

                return {
                  'color': colorValue
                }; // Apply mainBrandingColor to the text color
              }

              return null; // Return null for other elements to apply default style
            },
          ),
        ),
      ),
    );
  }
}
