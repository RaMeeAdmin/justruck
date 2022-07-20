import 'package:justruck/other/strings.dart';

class BeanVehicleBrand
{
  String _brandId = "", _brandName = "", _displayName = "";


  BeanVehicleBrand(this._brandId, this._brandName, this._displayName);

  get brandName => _brandName;

  set brandName(value) {
    _brandName = value;
  }

  String get brandId => _brandId;

  set brandId(String value) {
    _brandId = value;
  }

  get displayName => _displayName;

  set displayName(value) {
    _displayName = value;
  }

  static List<BeanVehicleBrand> getDefaultBrands()
  {
    List<BeanVehicleBrand> _listVehicleBrand = List.empty(growable: true);

    _listVehicleBrand.add(BeanVehicleBrand("0", Strings.selectVehicleBrand+" *", Strings.selectVehicleBrand+" *"));

    return _listVehicleBrand;
  }
}