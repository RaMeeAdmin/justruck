import 'package:justruck/other/strings.dart';

class BeanLicenseType
{
  String _typeId = "", _typeName = "", _displayName = "";


  BeanLicenseType(this._typeId, this._typeName, this._displayName);

  String get typeId => _typeId;

  set typeId(String value) {
    _typeId = value;
  }

  get typeName => _typeName;

  set typeName(value) {
    _typeName = value;
  }

  get displayName => _displayName;

  set displayName(value) {
    _displayName = value;
  }

  static List<BeanLicenseType> getDefaultTypes()
  {
    List<BeanLicenseType> listTypes = List.empty(growable: true);
    listTypes.add(BeanLicenseType("0", Strings.selectLicenseType, ""));

    return listTypes;
  }
}