import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/recitation_provider.dart';
import 'package:nour_al_quran/pages/quran/widgets/subtitle_text.dart';
import 'package:nour_al_quran/pages/settings/pages/download_manager/download_manager_provider.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:nour_al_quran/shared/widgets/circle_button.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class DownloadManagerPage extends StatefulWidget {
  const DownloadManagerPage({Key? key}) : super(key: key);

  @override
  State<DownloadManagerPage> createState() => _DownloadManagerPageState();
}

class _DownloadManagerPageState extends State<DownloadManagerPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      context.read<DownloadManagerProvider>().getReciters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        context.read<DownloadManagerProvider>().resetReciters();
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(context: context,title: localeText(context,"download_manager")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const TitleRow(title: "Download Manager"),
            SizedBox(height: 35.h,),
            SubTitleText(title: localeText(context,"downloaded_audio")),
            Consumer<DownloadManagerProvider>(
              builder: (context, value, child) {
                return Expanded(
                  child: value.whichHaveDownloaded.isNotEmpty ? ListView.builder(
                    itemCount: value.whichHaveDownloaded.length,
                    itemBuilder: (context, index) {
                      Reciters reciter = value.whichHaveDownloaded![index];
                      return InkWell(
                        onTap: (){
                          value.goToDownloadAudios(index, context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 10.w),
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
                                    imageUrl: reciter.imageUrl!,
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        CircularProgressIndicator(value: downloadProgress.progress,strokeWidth: 1,),
                                    errorWidget: (context, url, error) => const Icon(Icons.person),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
                                child: Text(reciter.reciterName!, style: TextStyle(fontSize: 15.5.sp, fontFamily: "satoshi", fontWeight: FontWeight.w700),),
                              ),
                            ],
                          ),
                        ),
                      );
                    },) : const Center(child: Text('No Downloaded Audios Yet'),),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
