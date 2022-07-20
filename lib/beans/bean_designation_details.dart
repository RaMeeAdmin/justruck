class BeanDesignationDetails
{
  String _designationId = "";
  String _designationName = "";

  String get designationId => _designationId;

  BeanDesignationDetails(this._designationId, this._designationName);

  set designationId(String value)
  {
    _designationId = value;
  }

  String get designationName => _designationName;

  set designationName(String value)
  {
    _designationName = value;
  }

  static List<BeanDesignationDetails> getDefaultDesignation()
  {
    List<BeanDesignationDetails> _listDesignations = List.empty(growable: true);

    _listDesignations.add(BeanDesignationDetails("0", "Select Designation *"));

    return _listDesignations;
  }
}