import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/quran/widgets/subtitle_text.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/circle_button.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';
import 'download_manager_provider.dart';

class ReciterDownloadSurahPage extends StatelessWidget {
  const ReciterDownloadSurahPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context,"download_manager")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const TitleRow(title: "Download Manager"),
          SizedBox(height: 35.h,),
          const SubTitleText(title: "Downloaded Audio"),
          Consumer<DownloadManagerProvider>(
            builder: (context, value, child) {
              return Expanded(
                child: value.downloadSurahs.isNotEmpty ? ListView.builder(
                  itemCount: value.downloadSurahs.length,
                  itemBuilder: (context, index) {
                    Surah surah = value.downloadSurahs[index];
                    return Container(
                      margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 10.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: AppColors.grey4)
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 33.h,
                            width: 33.w,
                            margin: EdgeInsets.only(top: 11.h, left: 10.w, bottom: 10.h, right: 8.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: value.recitersName!.imageUrl!,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress,strokeWidth: 1,),
                                errorWidget: (context, url, error) => const Icon(Icons.person),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value.recitersName!.reciterName!, style: TextStyle(fontSize: 15.5.sp, fontFamily: "satoshi", fontWeight: FontWeight.w700),),
                                Text('${surah.surahName}, Chapter ${surah.surahId}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, fontFamily: "satoshi", color: AppColors.grey3),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              value.deleteDownloadedSurah(surah.surahId.toString(),index,value.recitersName!);
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 10.w,right: 10.w),
                                child: CircleButton(height: 21.h, width: 21.w, icon: ImageIcon(const AssetImage('assets/images/app_icons/trash.png'),size: 11.h,))),
                          )
                        ],
                      ),
                    );
                  },) : const Center(child: Text('No Audio For this reciter'),),
              );
            },
          ),
        ],
      ),
    );
  }
}
