import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';

class BeanParcelItemDetails
{
  String _itemType = "";
  String _parcelDescription = "", _parcelWeight = "";
  String _declaredValue = "", _quantity = "";
  String _volume = "", _length = "", _breadth = "", _height = "";
  String _amount = "";


  BeanParcelItemDetails(
      this._itemType,
      this._parcelDescription, this._parcelWeight,
      this._declaredValue, this._quantity, this._volume,
      this._length, this._breadth, this._height,
      this._amount);


  String get itemType => _itemType;

  set itemType(String value) {
    _itemType = value;
  }

  String get parcelDescription => _parcelDescription;

  set parcelDescription(String value) {
    _parcelDescription = value;
  }

  get parcelWeight => _parcelWeight;

  set parcelWeight(value) {
    _parcelWeight = value;
  }

  String get declaredValue => _declaredValue;

  set declaredValue(String value) {
    _declaredValue = value;
  }

  get quantity => _quantity;

  set quantity(value) {
    _quantity = value;
  }

  String get volume => _volume;

  set volume(String value) {
    _volume = value;
  }

  get amount => _amount;

  set amount(value) {
    _amount = value;
  }

  get height => _height;

  set height(value) {
    _height = value;
  }

  get breadth => _breadth;

  set breadth(value) {
    _breadth = value;
  }

  get length => _length;

  set length(value) {
    _length = value;
  }
}