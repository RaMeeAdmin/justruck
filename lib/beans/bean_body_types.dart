import 'package:justruck/other/strings.dart';

class BeanBodyTypes
{
  String _typeId = "", _typeName = "";


  BeanBodyTypes(this._typeId, this._typeName);

  String get typeId => _typeId;

  set typeId(String value) {
    _typeId = value;
  }

  get typeName => _typeName;

  set typeName(value) {
    _typeName = value;
  }

  static List<BeanBodyTypes> getDefaultBodyTypes()
  {
    List<BeanBodyTypes> _listBodyTypes = List.empty(growable: true);

    _listBodyTypes.add(BeanBodyTypes("0", Strings.bodyTypes[0]+" *"));
    _listBodyTypes.add(BeanBodyTypes("1", Strings.bodyTypes[1]));
    _listBodyTypes.add(BeanBodyTypes("2", Strings.bodyTypes[2]));
    _listBodyTypes.add(BeanBodyTypes("3", Strings.bodyTypes[3]));

    return _listBodyTypes;
  }
}