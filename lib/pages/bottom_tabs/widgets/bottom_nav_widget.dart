import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../shared/localization/localization_constants.dart';
import '../../../shared/utills/app_colors.dart';
import '../../quran/pages/recitation/reciter/player/mini_player.dart';
import '../../settings/pages/app_colors/app_colors_provider.dart';
import '../provider/bottom_tabs_page_provider.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomTabsPageProvider, AppColorsProvider>(
      builder: (context, bottomTabProvider, appColors, child) {
        final int currentPage = bottomTabProvider.currentPage;
        int previousPage = 0;
        return WillPopScope(
          onWillPop: () async {
            if (currentPage != 0) {
              bottomTabProvider.setCurrentPage(previousPage);
              return false;
            }
            return true;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: currentPage != 2,
                child: const MiniPlayer(),
              ),
              Visibility(
                visible: currentPage != 2,
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        label: localeText(context, 'home'),
                        icon: _buildIcon('assets/images/app_icons/home.png')),
                    BottomNavigationBarItem(
                        label: localeText(context, 'quran'),
                        icon: _buildIcon(
                            'assets/images/app_icons/quran_icon.png')),
                    BottomNavigationBarItem(
                        label: localeText(context, 'qaida'),
                        icon: _buildIcon(
                            'assets/images/app_icons/qaidaiconnew.png')),
                    BottomNavigationBarItem(
                        label: localeText(context, 'discover'),
                        icon:
                            _buildIcon('assets/images/app_icons/explore.png')),
                    // BottomNavigationBarItem(
                    //     label: "Qaida",
                    //     icon: buildIcon('assets/images/app_icons/qaida_icon.png')),
                    BottomNavigationBarItem(
                        label: localeText(context, 'profile'),
                        icon:
                            _buildIcon('assets/images/app_icons/profile.png')),
                  ],
                  // backgroundColor: Colors.white,
                  currentIndex: bottomTabProvider.currentPage,
                  iconSize: 16.h,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  selectedIconTheme: IconThemeData(size: 18.h),
                  selectedItemColor: appColors.mainBrandingColor,
                  unselectedItemColor: AppColors.grey3,
                  selectedLabelStyle:
                      TextStyle(fontFamily: 'satoshi', fontSize: 12.5.sp),
                  unselectedLabelStyle:
                      TextStyle(fontFamily: 'satoshi', fontSize: 12.5.sp),
                  onTap: (page) async {
                    bottomTabProvider.setCurrentPage(page);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _buildIcon(String image) {
    return Container(
        margin: EdgeInsets.only(bottom: 5.h),
        child: ImageIcon(
          AssetImage(image),
        ));
  }
}
