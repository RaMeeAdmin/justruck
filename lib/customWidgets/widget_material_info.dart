import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_item_type.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';

class WidgetMaterialInfo
{
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerDeclaredValue = TextEditingController();
  TextEditingController controllerQuantity = TextEditingController();

  TextEditingController controllerLength = TextEditingController();
  TextEditingController controllerBreadth = TextEditingController();
  TextEditingController controllerHeight = TextEditingController();

  TextEditingController controllerAmount = TextEditingController();

  late BeanItemType selectedItem;
  late String volume = "0";

  WidgetMaterialInfo();
}