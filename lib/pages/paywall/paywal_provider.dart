import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PremiumScreenProvider extends ChangeNotifier {
  int _focusedIndex = 1;

  int get focusedIndex => _focusedIndex;

  void setFocusedIndex(int index) {
    if (_focusedIndex != index) {
      _focusedIndex = index;
      notifyListeners();
    }
  }
}

class ContainerModel {
  final int id;
  late final bool isTapped;

  ContainerModel({
    required this.id,
    required this.isTapped,
  });
}

class UserModel {
  final String name;
  final String rating;
  final String avatarUrl;
  final String description;

  UserModel({
    required this.name,
    required this.rating,
    required this.avatarUrl,
    required this.description,
  });
}
