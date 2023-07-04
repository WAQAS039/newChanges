import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/home/provider/home_provider.dart';
import 'package:nour_al_quran/pages/quran/providers/quran_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/translation_manager/translations.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';
import 'package:nour_al_quran/shared/widgets/easy_loading.dart';
import 'package:provider/provider.dart';

class TranslationManagerProvider extends ChangeNotifier{
  final List<Translations> _translations =   Hive.box(appBoxKey).get(availbleQuranTranslationsListKey) != null
      ? (jsonDecode(Hive.box(appBoxKey).get(availbleQuranTranslationsListKey)) as List<dynamic>).map((e) => Translations.fromJson(e)).toList() :[
    Translations(title: "English - Pickthall", image: "assets/images/flags/en.png",url: "https://tanzil.net/trans/en.pickthall",translationName: "translation_english_pickthall",bis: "In the name of Allah, the Beneficent, the Merciful.", duaTrans: "english"),
    Translations(title: "English - sahih", image: "assets/images/flags/en.png",url: "https://tanzil.net/trans/en.sahih",translationName: "translation_english_sahih",bis: "In the name of Allah, the Entirely Merciful, the Especially Merciful.", duaTrans: "english"),
    Translations(title: "Arabic - muyassar", image: "assets/images/flags/ar.png",url: "https://tanzil.net/trans/ar.muyassar",translationName: "translation_arabic_muyassar",bis: "سورة الفاتحة سميت هذه السورة بالفاتحة؛ لأنه يفتتح بها القرآن العظيم، وتسمى المثاني؛ لأنها تقرأ في كل ركعة، ولها أسماء أخر. أبتدئ قراءة القرآن باسم الله مستعينا به، (اللهِ) علم على الرب -تبارك وتعالى- المعبود بحق دون سواه، وهو أخص أسماء الله تعالى، ولا يسمى به غيره سبحانه. (الرَّحْمَنِ) ذي الرحمة العامة الذي وسعت رحمته جميع الخلق، (الرَّحِيمِ) بالمؤمنين، وهما اسمان من أسمائه تعالى، يتضمنان إثبات صفة الرحمة لله تعالى كما يليق بجلاله", duaTrans: "arabic"),
    Translations(title: "Urdu - jalandhry", image: "assets/images/flags/pk.png",url: "https://tanzil.net/trans/ur.jalandhry",translationName: "translation_ur_jalandhry",bis: "شروع الله کا نام لے کر جو بڑا مہربان نہایت رحم والا ہے", duaTrans: "urdu"),
    Translations(title: "Urdu - Kanzuliman", image: "assets/images/flags/pk.png",url: "https://tanzil.net/trans/ur.kanzuliman",translationName: "translation_urdu_kanzuliman",bis: "اللہ کے نام سے شروع جو بہت مہربان رحمت والا", duaTrans: "urdu"),
    Translations(title: "Spanish - Garcia", image: "assets/images/flags/es.png",url: "https://tanzil.net/trans/es.garcia",translationName: "translation_spanish_garcia",bis: "En el nombre de Dios, el Compasivo con toda la creación, el Misericordioso con los creyentes", duaTrans: "spanish"),
    Translations(title: "Spanish - Cortes", image: "assets/images/flags/es.png",url: "https://tanzil.net/trans/es.cortes",translationName: "translation_spanish_cortes",bis: "¡En el nombre de Alá, el Compasivo, el Misericordioso!", duaTrans: "spanish"),
    Translations(title: "Indonesia - indonesian", image:  "assets/images/flags/id.png",url: "https://tanzil.net/trans/id.indonesian",translationName: "translation_idonesian_indonesia",bis: "Dengan menyebut nama Allah Yang Maha Pemurah lagi Maha Penyayang", duaTrans: "indonesian"),
    Translations(title: "Hindi - hindi", image:  "assets/images/flags/in.png",url: "https://tanzil.net/trans/hi.hindi",translationName: "translation_hindi_hindi",bis: "अल्लाह के नाम से जो रहमान व रहीम है", duaTrans: "hindi"),
    Translations(title: "French - Hamdiulla", image:  "assets/images/flags/fr.png",url: "https://tanzil.net/trans/fr.hamidullah",translationName: "translation_french_hamdiulla",bis: "Au nom d'Allah, le Tout Miséricordieux, le Très Miséricordieux", duaTrans: "french"),
    Translations(title: "Persian - ghomshei", image:  "assets/images/flags/pr.png",url: "https://tanzil.net/trans/fa.ghomshei",translationName: "translation_persian_ghomshei",bis: "به نام خداوند بخشنده مهربان", duaTrans: "english"),
    Translations(title: "Persian - makarem", image:  "assets/images/flags/pr.png",url: "https://tanzil.net/trans/fa.makarem",translationName: "translation_persian_makarem",bis: "به نام خداوند بخشنده بخشایشگر", duaTrans: "english"),
    Translations(title: "Malay - basmeih", image:  "assets/images/flags/ml.png",url: "https://tanzil.net/trans/ms.basmeih",translationName: "translation_malay_basmeih",bis: "Dengan nama Allah, Yang Maha Pemurah, lagi Maha Mengasihani", duaTrans: "english"),
    Translations(title: "Turkish - diyanet", image:  "assets/images/flags/tr.png",url: "https://tanzil.net/trans/tr.vakfi",translationName: "translation_turkish_diyanet",bis: "Rahman (ve) rahim (olan) Allah'ın adıyla", duaTrans: "english"),
    Translations(title: "Turkish - yazir", image:  "assets/images/flags/tr.png",url: "https://tanzil.net/trans/tr.yazir",translationName: "translation_turkish_yazir",bis: "Rahmân ve Rahîm olan Allah'ın ismiyle", duaTrans: "english"),
    Translations(title: "German - aburida", image:  "assets/images/flags/gr.png",url: "https://tanzil.net/trans/de.aburida",translationName: "translation_german_aburida",bis: "Im Namen Allahs, des Allerbarmers, des Barmherzigen!", duaTrans: "english"),
    Translations(title: "German - bubenheim", image:  "assets/images/flags/gr.png",url: "https://tanzil.net/trans/de.bubenheim",translationName: "translation_german_bubenheim",bis: "Im Namen Allahs, des Allerbarmers, des Barmherzigen", duaTrans: "german"),
    Translations(title: "German - zaida", image:  "assets/images/flags/gr.png",url: "https://tanzil.net/trans/de.zaidan",translationName: "translation_german_zaida",bis: "Bismil-lahir-rahmanir-rahim: Mit dem Namen ALLAHs, Des Allgnade Erweisenden, Des Allgnädigen, (rezitiere ich)", duaTrans: "german"),
    Translations(title: "Bangali - hoque", image:  "assets/images/flags/bn.png",url: "https://tanzil.net/trans/bn.hoque",translationName: "translation_bangali_hoque",bis: "আল্লাহর নাম নিয়ে (আরম্ভ করছি), (যিনি) রহমান (--পরম করুণাময়, যিনি অসীম করুণা ও দয়া বশতঃ বিশ্বজগতের সমস্ত সৃষ্টির সহাবস্থানের প্রয়োজনীয় সব ব্যবস্থা অগ্রিম করে রেখেছেন), (যিনি) রহীম (--অফুরন্ত ফলদাতা, যাঁর অপার করুণা ও দয়ার ফলে প্রত্যেকের ক্ষুদ্রতম শুভ-প্রচেষ্টাও বিপুলভাবে সাফল্যমণ্ডিত ও পুরস্কৃত হয়ে থাকে)", duaTrans: "bengali"),
    Translations(title: "Bangali - Muhiuddin", image:  "assets/images/flags/bn.png",url: "https://tanzil.net/trans/bn.bengali",translationName: "translation_bangali_bengali",bis: "শুরু করছি আল্লাহর নামে যিনি পরম করুণাময়, অতি দয়ালু", duaTrans: "bengali"),
    Translations(title: "Somali - abduh", image:  "assets/images/flags/so.png",url: "https://tanzil.net/trans/so.abduh",translationName: "translation_somali_abduh",bis: "Magaca Eebe yaan kubillaabaynaa ee Naxariis guud iyo mid gaaraba Naxariista", duaTrans: "somalia"),
    Translations(title: "Chinese - jian", image:  "assets/images/flags/cz.png",url: "https://tanzil.net/trans/zh.jian",translationName: "translation_chinese_jian",bis: "奉至仁至慈的真主之名", duaTrans: "chinese"),
    Translations(title: "Chinese - majian", image:  "assets/images/flags/cz.png",url: "https://tanzil.net/trans/zh.majian",translationName: "translation_chinese_majian",bis: "奉至仁至慈的真主之名", duaTrans: "chinese"),
  ];
  List<Translations> get translations => _translations;
  
  final List<Translations> _defaultTranslations = Hive.box(appBoxKey).get(downloadedTranslationsListKey) != null
      ? (jsonDecode(Hive.box(appBoxKey).get(downloadedTranslationsListKey)) as List<dynamic>).map((e) => Translations.fromJson(e)).toList() : [
    Translations(title: "English - hilali", image: "assets/images/flags/en.png",url: "https://tanzil.net/trans/en.hilali",translationName: "translation_english_hilali",bis: "In the Name of Allah, the Most Beneficent, the Most Merciful", duaTrans: "english"),
    Translations(title: "Urdu - Ahmedali", image: "assets/images/flags/pk.png",url: "https://tanzil.net/trans/ur.ahmedali",translationName: "translation_urdu_ahmedali",bis: "شروع الله کا نام لے کر جو بڑا مہربان نہایت رحم والا ہے", duaTrans: "urdu"),
    Translations(title: "Hindi - Farooq", image:  "assets/images/flags/in.png",url: "https://tanzil.net/trans/hi.farooq",translationName: "translation_hindi_farooq",bis: "अल्लाह के नाम से जो बड़ा कृपालु और अत्यन्त दयावान हैं", duaTrans: "hindi"),
    Translations(title: "Indonesia - Muntakhab", image:  "assets/images/flags/id.png",url: "https://tanzil.net/trans/id.muntakhab",translationName: "translation_indonesian_muntakhab",bis: "Dialah Pemilik rahmah (sifat kasih) yang tak habis-habisnya, Yang menganugerahkan segala macam kenikmatan, baik besar maupun kecil", duaTrans: "indonesian"),
    Translations(title: "Arabic - Jalalayn", image:  "assets/images/flags/ar.png",url: "https://tanzil.net/trans/ar.jalalayn",translationName: "translation_arabic_jalalayn",bis: "«بسم الله الرحمن الرحيم»", duaTrans: "arabic"),
  ];

  List<Translations> get defaultTranslations => _defaultTranslations;

  Translations _defaultSelectedTranslation = Translations(title: "English - hilali", image: "assets/images/flags/en.png",url: "https://tanzil.net/trans/en.hilali",translationName: "translation_english_hilali",bis: "In the Name of Allah, the Most Beneficent, the Most Merciful", duaTrans: "english");
  Translations get defaultSelectedTranslation => _defaultSelectedTranslation;
  Translations _finalSelected = Hive.box(appBoxKey).get(selectedQuranTranslationKey) != null ? Translations.fromJson(jsonDecode(Hive.box(appBoxKey).get(selectedQuranTranslationKey))):Translations(title: "English - hilali", image: "assets/images/flags/en.png",url: "https://tanzil.net/trans/en.hilali",translationName: "translation_english_hilali",bis: "In the Name of Allah, the Most Beneficent, the Most Merciful", duaTrans: "english");
  Translations get finalSelected => _finalSelected;

  void init(){
    // print(Translations.fromJson(jsonDecode(Hive.box(appBoxKey).get(selectedQuranTranslationKey))));
    _defaultSelectedTranslation = _finalSelected;
    notifyListeners();
  }

  void downloadTranslation(int index,BuildContext context){
    EasyLoadingDialog.show(context: context,radius: 20.r);
    // to update bismillah
    QuranDatabase().updateBissmillahOfEachTranslation(_translations[index].bismillah!, _translations[index].translationName!);
    downloadTranslations(_translations[index].translationName!,_translations[index].url!,index,context);
  }

  void selectTranslation(Translations trans){
    _defaultSelectedTranslation = trans;
    notifyListeners();
  }

  void saveSelectedTranslation(BuildContext context){
    _finalSelected = _defaultSelectedTranslation;
    notifyListeners();
    Hive.box(appBoxKey).put(selectedQuranTranslationKey, jsonEncode(_finalSelected));
    Hive.box(appBoxKey).put(duaTranslationKey, "translation_${_finalSelected.duaTranslation}");
    Hive.box(appBoxKey).put(miraclesTranslationKey, "translation_${_finalSelected.duaTranslation}");
    // Hive.box(appBoxKey).put(quranStoriesTranslationKey, "translation_${_finalSelected.duaTranslation}");
    Hive.box(appBoxKey).put(basicsTranslationKey, "translation_${_finalSelected.duaTranslation}");
    context.read<HomeProvider>().updateVerseTranslation();
    // context.read<QuranProvider>().updateState(_finalSelected.translationName!);
  }


Future<void> downloadTranslations(String translatorName,String url,int index,BuildContext context) async {
  final response = await Dio().get(url);
  if (response.statusCode == 200) {
    var apiResponse = response.data;
    var list = apiResponse.split("\n");
    var translations = [];
    for(int i = 0;i<6236;i++){
      translations.add(list[i].split("|"));
    }
    if(translations.length >= 6230){
      Future.delayed(Duration.zero,() async{
        await QuranDatabase().updateQuranTranslations(translations,translatorName,context,index);
      });
    }
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

 void updateState(int index,BuildContext context){
   // add new in default translations list
   _defaultTranslations.add(_translations[index]);
   // remove download form availble translation
   _translations.removeAt(index);
   notifyListeners();
   Hive.box(appBoxKey).put(downloadedTranslationsListKey, jsonEncode(_defaultTranslations));
   Hive.box(appBoxKey).put(availbleQuranTranslationsListKey, jsonEncode(_translations));
   EasyLoadingDialog.dismiss(context);
 }

}