class BeanCity
{
  String _cityId = "0", _cityName = "";
  String _pinCode = "", _districtName = "", _stateName = "", _stateCode = "", _countryName = "";

  BeanCity(this._cityId, this._cityName);


  String get cityId => _cityId;

  set cityId(String value) {
    _cityId = value;
  }

  get cityName => _cityName;

  set cityName(value) {
    _cityName = value;
  }

  get countryName => _countryName;

  set countryName(value) {
    _countryName = value;
  }

  get stateCode => _stateCode;

  set stateCode(value) {
    _stateCode = value;
  }

  get stateName => _stateName;

  set stateName(value) {
    _stateName = value;
  }

  get districtName => _districtName;

  set districtName(value) {
    _districtName = value;
  }

  String get pinCode => _pinCode;

  set pinCode(String value) {
    _pinCode = value;
  }

  static List<BeanCity> getDefaultCities()
  {
    List<BeanCity> types = List.empty(growable: true);

    types.add(BeanCity("0", "Select Company City"));
    /*types.add(BeanCity("1", "City Name 1"));
    types.add(BeanCity("2", "City Name 2"));
    types.add(BeanCity("3", "City Name 3"));*/

    return types;
  }
}