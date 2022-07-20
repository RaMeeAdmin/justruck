import 'package:flutter/cupertino.dart';
import 'package:justruck/other/common_constants.dart';

class BeanPaymentMode
{
  String _modeId = "";
  String _modeName = "";
  bool _selected = false;

  TextEditingController _controllerAmountTendered = TextEditingController();


  BeanPaymentMode(this._modeId, this._modeName);

  String get modeId => _modeId;

  set modeId(String value) {
    _modeId = value;
  }

  String get modeName => _modeName;

  bool get selected => _selected;

  set selected(bool value) {
    _selected = value;
  }

  set modeName(String value) {
    _modeName = value;
  }


  TextEditingController get controllerAmountTendered =>
      _controllerAmountTendered;

  set controllerAmountTendered(TextEditingController value) {
    _controllerAmountTendered = value;
  }

  static List<BeanPaymentMode> getAvailablePaymentModes()
  {
    List<BeanPaymentMode> _listPayModes = List.empty(growable: true);

    BeanPaymentMode modeCash = BeanPaymentMode(CommonConstants.payModeCash, CommonConstants.payModeCash);
    _listPayModes.add(modeCash);

    BeanPaymentMode modeCard = BeanPaymentMode(CommonConstants.payModeCard, CommonConstants.payModeCard);
    _listPayModes.add(modeCard);

    BeanPaymentMode modeUPI = BeanPaymentMode(CommonConstants.payModeUPI, CommonConstants.payModeUPI);
    _listPayModes.add(modeUPI);

    BeanPaymentMode modeCredit = BeanPaymentMode(CommonConstants.payModeCredit, CommonConstants.payModeCredit);
    _listPayModes.add(modeCredit);

    return _listPayModes;
  }
}