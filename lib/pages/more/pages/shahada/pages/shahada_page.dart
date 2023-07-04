import 'package:flutter/material.dart';
import 'package:nour_al_quran/pages/more/pages/shahada/widgets/shahada_container.dart';
import '../../../../../shared/widgets/app_bar.dart';

class ShahadahPage extends StatelessWidget {
  const ShahadahPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context,title: "Shahadah"),
      body: const ShahadaContainer(),
    );
  }
}
