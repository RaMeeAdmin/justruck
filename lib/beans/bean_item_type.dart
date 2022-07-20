class BeanItemType
{
  String _typeId = "", _typeName = "";


  BeanItemType(this._typeId, this._typeName);

  String get typeId => _typeId;

  set typeId(String value) {
    _typeId = value;
  }

  get typeName => _typeName;

  set typeName(value) {
    _typeName = value;
  }

  static List<BeanItemType> getDefaultItemList()
  {
    List<BeanItemType> listItemTypes = List.empty(growable: true);

    listItemTypes.add(BeanItemType("0", "Select Item Type"));

    return listItemTypes;
  }
}