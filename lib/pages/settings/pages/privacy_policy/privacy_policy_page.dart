import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';

import '../../../../shared/widgets/app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context, "privacy_policy")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 20.h,bottom: 10.h),
          child: Text("Lorem ipsum dolor sit amet consectetur. At volutpat cras aliquam commodo. Blandit fusce ut proin molestie. A vitae massa at facilisis. Malesuada lacus ut tristique mattis congue posuere amet vitae adipiscing. Quisque eget maecenas sed tellus aenean rhoncus euismod molestie molestie. Integer luctus nunc purus tempus. Porta nec facilisis tempus felis fusce. Eros enim tincidunt sagittis ut condimentum auctor proin cursus. Dui tincidunt vel eget velit. Morbi vulputate quam sollicitudin cursus cras risus at quam nascetur. Fusce turpis dui id a dolor. Id quam ullamcorper nisi lacus dapibus eu consectetur. Neque augue mauris arcu nisi feugiat tortor eu feugiat. In at diam augue fringilla elit ac.Sed quam nunc commodo vitae augue. Accumsan quis lacus risus orci eget cursus. Interdum rhoncus hac ut mi mi placerat nullam elementum mattis. Elit lorem facilisis vel aliquam rhoncus vel accumsan. Quisque lectus auctor vestibulum ullamcorper adipiscing blandit. Ultricies amet ornare eros feugiat. Eu magna cras aliquam est tellus porttitor. Arcu id enim feugiat nunc ut consectetur tellus enim scelerisque. Vivamus sed bibendum dui lacus sed. Enim dictum nisl semper dictum id. Amet sit phasellus elementum lorem amet ipsum et. Nunc est elit tristique et nunc urna aliquet sagittis pulvinar. Et nec sed imperdiet "
              "sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie.sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie."
              "sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie."
              "sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie."
              "sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie."
              "sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie."
              "sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie."
              "sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie."
              "sollicitudin porttitor praesent commodo felis eu. Bibendum elementum pulvinar ut malesuada cras molestie.",
            style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 14.sp),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
