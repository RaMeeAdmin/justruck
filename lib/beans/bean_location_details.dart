class BeanLocationDetails
{
  String _latitude = "", _longitude = "";
  String _address = "";

  String get latitude => _latitude;

  BeanLocationDetails(this._latitude, this._longitude, this._address);

  set latitude(String value) {
    _latitude = value;
  }

  get longitude => _longitude;

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  set longitude(value) {
    _longitude = value;
  }
}