import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController searchController;
  final Function(String)? onChange;
  const SearchWidget(
      {Key? key,
      required this.hintText,
      required this.searchController,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 10.w,
      ),
      child: TextField(
        controller: searchController,
        onChanged: onChange,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: 12.h, bottom: 11.h, left: 10.w, right: 10.w),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 10.sp,
              fontFamily: 'satoshi',
              // color: AppColors.grey2
            ),
            suffixIcon: Icon(
              Icons.search,
              size: 12.h,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.grey5),
                borderRadius: BorderRadius.circular(6.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.grey5),
                borderRadius: BorderRadius.circular(6.r))),
      ),
    );
  }
}
