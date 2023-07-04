import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
//import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/recitation_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/reciter_provider.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/widgets/app_bar.dart';

class AllReciters extends StatelessWidget {
  const AllReciters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: localeText(context, "all_reciters"),
        font: 16.sp,
      ),
      body: Consumer<RecitationProvider>(
        builder: (context, recitersValue, child) {
          return GridView.builder(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            itemCount: recitersValue.recitersList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: 116.87.h,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 5.w),
            itemBuilder: (BuildContext context, int index) {
              Reciters reciter = recitersValue.recitersList[index];
              return InkWell(
                onTap: () async {
                  recitersValue.getSurahName();
                  // context.read<ReciterProvider>().resetDownloadSurahList();
                  context
                      .read<ReciterProvider>()
                      .setReciterList(reciter.downloadSurahList!);
                  Navigator.of(context)
                      .pushNamed(RouteHelper.reciter, arguments: reciter);
                },
                child: buildReciterDetailsContainer(reciter),
              );
            },
          );
        },
      ),
    );
  }

  Container buildReciterDetailsContainer(Reciters reciter) {
    return Container(
      margin: EdgeInsets.only(right: 7.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 71.18.h,
            width: 71.18.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35.59.r),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: reciter.imageUrl!,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: AppColors.mainBrandingColor,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.person),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            reciter.reciterName!,
            softWrap: true,
            maxLines: 3,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                height: 1.3.h,
                fontFamily: "satoshi"),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
