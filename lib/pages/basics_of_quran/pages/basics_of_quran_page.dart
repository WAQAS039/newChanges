import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nour_al_quran/pages/basics_of_quran/widgets/islam_basics_list.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:provider/provider.dart';
import '../../../shared/widgets/app_bar.dart';
import '../models/islam_basics.dart';
import '../provider/islam_basics_provider.dart';

class BasicsOfQuranPage extends StatelessWidget {
  const BasicsOfQuranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context, "islam_basics")),
      body: const IslamBasicList(),
    );
  }
}
