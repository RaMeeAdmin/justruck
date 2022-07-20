import 'package:justruck/other/strings.dart';

class BeanRtoDetails
{
  String _id = "";
  String _stateName = "", _cityName = "", _name = "", _displayName = "";

  BeanRtoDetails(this._id, this._name, this._displayName);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get stateName => _stateName;

  get displayName => _displayName;

  set displayName(value) {
    _displayName = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get cityName => _cityName;

  set cityName(value) {
    _cityName = value;
  }

  set stateName(String value) {
    _stateName = value;
  }

  static List<BeanRtoDetails> getDefaultRtoList()
  {
    List<BeanRtoDetails> listRto = List.empty(growable: true);

    listRto.add(BeanRtoDetails("0", Strings.selectRTO+" *", Strings.selectRTO+" *"));

    return listRto;
  }
}