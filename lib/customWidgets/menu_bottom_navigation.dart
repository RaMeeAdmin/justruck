import 'package:flutter/material.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';

class MenuBottomNavigation
{
  static List<BottomNavigationBarItem> getBottomNavigationMenu(BuildContext context, String role)
  {
    List<BottomNavigationBarItem> _listMenus = List.empty(growable: true);

    _listMenus.add(BottomNavigationBarItem(
      activeIcon: const Icon(Icons.home, color: logo3,),
      icon: const Icon(Icons.home, color: Colors.grey,),
      label: S.of(context).home,
    ));

    _listMenus.add(BottomNavigationBarItem(
      activeIcon: const Icon(Icons.qr_code_scanner, color: logo3,),
      icon: const Icon(Icons.qr_code_scanner, color: Colors.grey,),
      label: S.of(context).scanQR,
    ));

    _listMenus.add(BottomNavigationBarItem(
      activeIcon: const Icon(Icons.location_on_sharp, color: logo3,),
      icon: const Icon(Icons.location_on_sharp, color: Colors.grey,),
      label: S.of(context).trackParcel,
    ));

    if(role == CommonConstants.typeTransporter)
    {
      _listMenus.add(BottomNavigationBarItem(
        activeIcon: const Icon(Icons.show_chart, color: logo3,),
        icon: const Icon(Icons.show_chart, color: Colors.grey,),
        label: S.of(context).reports,
      ));
    }

    /*return [
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.home, color: logo3,),
        icon: const Icon(Icons.home, color: Colors.grey,),
        label: S.of(context).home,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.qr_code_scanner, color: logo3,),
        icon: const Icon(Icons.qr_code_scanner, color: Colors.grey,),
        label: S.of(context).scanQR,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.location_on_sharp, color: logo3,),
        icon: const Icon(Icons.location_on_sharp, color: Colors.grey,),
        label: S.of(context).trackParcel,
      ),
    ];*/

    return _listMenus;
  }
}