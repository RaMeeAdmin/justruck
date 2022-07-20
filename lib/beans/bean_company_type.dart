class BeanCompanyType
{
  String _companyTypeId = "0", _companyTypeName = "" ;

  BeanCompanyType(this._companyTypeId, this._companyTypeName);

  get companyTypeName => _companyTypeName;

  set companyTypeName(value) {
    _companyTypeName = value;
  }

  String get companyTypeId => _companyTypeId;

  set companyTypeId(String value) {
    _companyTypeId = value;
  }

  static List<BeanCompanyType> getDefaultTypes()
  {
    List<BeanCompanyType> types = List.empty(growable: true);

    types.add(BeanCompanyType("0", "Select Company Type"));

    return types;
  }

}