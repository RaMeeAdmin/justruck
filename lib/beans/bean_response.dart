class BeanResponse
{
  bool _success = false;
  String _message = "";
  var _data;

  String _value1 = "";
  String _value2 = "";


  BeanResponse(this._success, this._message, this._data);

  get data => _data;

  set data(value) {
    _data = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  bool get success => _success;

  set success(bool value) {
    _success = value;
  }

  String get value1 => _value1;

  set value1(String value) {
    _value1 = value;
  }

  String get value2 => _value2;

  set value2(String value) {
    _value2 = value;
  }
}