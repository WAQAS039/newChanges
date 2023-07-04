import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:provider/provider.dart';

import '../provider/miracles_of_quran_provider.dart';
import '../models/miracles.dart';

class MiraclesContentText extends StatelessWidget {
  const MiraclesContentText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontProvider fontProvider = Provider.of<FontProvider>(context);
    Miracles miracles =
        context.read<MiraclesOfQuranProvider>().selectedMiracle!;
    try {
      return Expanded(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 16.h,
              bottom: 16.h,
            ),
            alignment: Alignment.center,
            child: FutureBuilder<String>(
              future:
                  Future<String>.delayed(const Duration(milliseconds: 100), () {
                // Simulating an asynchronous operation
                if (miracles.text == null) {
                  throw Exception('Text is null');
                }
                return miracles.text!;
              }),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasError) {
                  final error = snapshot.error.toString();
                  showErrorSnackBar('An error occurred: $error', context);
                  return const SizedBox
                      .shrink(); // Return an empty widget in case of an error
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final text = snapshot.data!;
                return HtmlWidget(
                  text,
                  textStyle: TextStyle(
                    fontFamily: 'satoshi',
                    fontSize: fontProvider.fontSizeTranslation.sp,
                  ),
                  customStylesBuilder: (element) {
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
                    if (element.localName == 'p' &&
                        element.classes.contains('arabic')) {
                      final appColorsProvider =
                          Provider.of<AppColorsProvider>(context);
                      final brandingColor = appColorsProvider.mainBrandingColor;
                      final colorValue =
                          '#${brandingColor.value.toRadixString(16).substring(2)}';
                      return {
                        'color': colorValue
                      }; // Apply mainBrandingColor to the text color
                    }
                    return null;
                    // Custom styles logic
                  },
                );
              },
            ),
          ),
        ),
      );
    } catch (e) {
      showErrorSnackBar('An error occurred: $e', context);
      return SizedBox.shrink(); // Return an empty widget in case of an error
    }
  }
}

void showErrorSnackBar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
