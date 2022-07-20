import 'package:justruck/other/strings.dart';

class BeanTransporterType
{
  String _transporterTypeId = "0", _transporterTypeName = "" ;

  BeanTransporterType(this._transporterTypeId, this._transporterTypeName);

  String get transporterTypeId => _transporterTypeId;

  set transporterTypeId(String value) {
    _transporterTypeId = value;
  }

  get transporterTypeName => _transporterTypeName;

  set transporterTypeName(value) {
    _transporterTypeName = value;
  }
}