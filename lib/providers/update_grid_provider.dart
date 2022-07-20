import 'package:flutter/material.dart';

class UpdateGridProvider with ChangeNotifier
{
  void languageHasChanged() {

    notifyListeners();
  }
}