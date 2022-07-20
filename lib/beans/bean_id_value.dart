import 'package:flutter/cupertino.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/common_constants.dart';

import '../other/strings.dart';

class BeanIdValue
{
  String _id = "", _value = "";
  bool checked = false;

  BeanIdValue(this._id, this._value);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get value => _value;

  set value(value) {
    _value = value;
  }

  static List<BeanIdValue> getCustomerTypeList()
  {
    List<BeanIdValue> _listCustomerTypes = List.empty(growable: true);

    BeanIdValue typeIndividual = BeanIdValue(CommonConstants.customerTypeIndividual, CommonConstants.customerTypeIndividual);
    typeIndividual.checked = true;
    _listCustomerTypes.add(typeIndividual);

    BeanIdValue typeFirm = BeanIdValue(CommonConstants.customerTypeFirm, CommonConstants.customerTypeFirm);
    typeFirm.checked = false;
    _listCustomerTypes.add(typeFirm);

    return _listCustomerTypes;
  }

  static List<BeanIdValue> getBookingTypes()
  {
    List<BeanIdValue> _listPaymentStatus = List.empty(growable: true);

    //BeanIdValue statusPaid = BeanIdValue(CommonConstants.payStatusPaid, CommonConstants.payStatusPaid);
    BeanIdValue statusPaid = BeanIdValue(CommonConstants.payStatusPaid, Strings.paidBooking);
    statusPaid.checked = true;
    _listPaymentStatus.add(statusPaid);

    //BeanIdValue statusToPay = BeanIdValue(CommonConstants.payStatusToPay, CommonConstants.payStatusToPay);
    BeanIdValue statusToPay = BeanIdValue(CommonConstants.payStatusToPay, Strings.toPayBooking);
    statusToPay.checked = false;
    _listPaymentStatus.add(statusToPay);

    return _listPaymentStatus;
  }
}