import 'package:flutter/material.dart';
import 'package:nour_al_quran/pages/miracles_of_quran/widgets/miracles_list.dart';
import '../../../shared/widgets/app_bar.dart';

class MiraclesOfQuranPage extends StatelessWidget {
  const MiraclesOfQuranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: "Miracles Of Quran",
      ),
      body: const MiraclesList(),
    );
  }
}
