import 'package:flutter/material.dart';
import 'package:nour_al_quran/pages/quran/widgets/subtitle_text.dart';
import 'package:nour_al_quran/pages/quran/pages/resume/where_you_left_off_widget.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleText(title: localeText(context, "continue_where_you_left_off")),
        const WhereULeftOffWidget()
      ],
    );
  }
}
