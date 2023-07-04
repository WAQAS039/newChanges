import 'package:flutter/material.dart';
import 'package:nour_al_quran/pages/quran/pages/juz/juz_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/quran/providers/quran_provider.dart';
import 'package:nour_al_quran/pages/quran/widgets/quran_text_view.dart';
import 'package:nour_al_quran/pages/quran/widgets/details_container_widget.dart';
import 'package:nour_al_quran/pages/quran/widgets/search_widget.dart';
import 'package:nour_al_quran/pages/quran/widgets/subtitle_text.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/entities/juz.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:provider/provider.dart';

class JuzIndexPage extends StatefulWidget {
  const JuzIndexPage({Key? key}) : super(key: key);

  @override
  State<JuzIndexPage> createState() => _JuzIndexPageState();
}

class _JuzIndexPageState extends State<JuzIndexPage> {
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<JuzProvider>().getJuzNames();
  }
  
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleText(title: localeText(context, "juz_index")),
        SearchWidget(
          hintText: localeText(context,"search_juz_name"), searchController: searchController,
          onChange: (value){
            context.read<JuzProvider>().searchJuz(value);
            },),
        Consumer<JuzProvider>(
          builder:(context, juzValue, child) {
            return  juzValue.juzNameList.isNotEmpty ? Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: juzValue.juzNameList.length,
                  itemBuilder: (context, index) {
                    Juz juz = juzValue.juzNameList[index];
                    return InkWell(
                      onTap: () async{
                        context.read<QuranProvider>().setJuzText(juzId: juz.juzId!,title: juz.juzArabic!,fromWhere: 1,isJuz: true,);
                        Future.delayed(Duration.zero,()=>context.read<RecitationPlayerProvider>().pause(context));
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          // title: juz.juzArabic!,fromWhere: 1,isJuz: true,juzId: index+1
                          return const QuranTextView();
                        },));
                      },
                      child: DetailsContainerWidget(
                        title: LocalizationProvider().checkIsArOrUr() ? juz.juzArabic!:juz.juzEnglish!,
                        subTitle: LocalizationProvider().checkIsArOrUr() ? "${localeText(context, "juz")} ${index+1}":"${localeText(context, "juz")} ${index+1} | ${juz.juzArabic}",
                        icon: Icons.remove_red_eye_outlined,
                        imageIcon: "assets/images/app_icons/view.png",
                      ),
                    );
                  },),
              ),
            ) : const Expanded(child: Center(child: Text('No Result Found'),));
          },
        ),
      ],
    );
  }
}
