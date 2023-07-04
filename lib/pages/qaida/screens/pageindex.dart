import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../shared/localization/localization_constants.dart';
import '../../../shared/utills/app_colors.dart';
import '../../../shared/widgets/app_bar.dart';
import '../../settings/pages/app_colors/app_colors_provider.dart';
import '../../settings/pages/app_them/them_provider.dart';

class QaidaPageIndex extends StatelessWidget {
  final int selectedIndex;

  final List<String> listData = [
    'Page 1',
    'Page 2',
    'Page 3',
    'Page 4',
    'Page 5',
    'Page 6',
    'Page 7',
    'Page 8',
    'Page 9',
    'Page 10',
    'Page 11',
    'Page 12',
    'Page 13',
    'Page 14',
    'Page 15',
    'Page 16',
    'Page 17',
    'Page 18',
    'Page 19',
  ];

  QaidaPageIndex({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    var appColors = context.read<AppColorsProvider>();
    var isDark = context.read<ThemProvider>().isDark;

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: localeText(context, "qaida_index"),
      ),
      body: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, index);
            },
            child: Container(
              margin: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: 8.h,
              ),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? isDark
                        ? AppColors.brandingDark
                        : AppColors.lightBrandingColor
                    : Colors.transparent,
                border: Border.all(
                  color: selectedIndex == index
                      ? appColors.mainBrandingColor
                      : isDark
                          ? AppColors.grey3
                          : AppColors.grey5,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  listData[index],
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
