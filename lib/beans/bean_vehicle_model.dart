import 'package:justruck/other/strings.dart';

class BeanVehicleModel
{
  String _modelId = "", _modelName = "", _displayName = "";
  String _brandId = "";


  BeanVehicleModel(this._modelId, this._modelName, this._displayName, this._brandId);

  String get modelId => _modelId;

  set modelId(String value) {
    _modelId = value;
  }

  get modelName => _modelName;

  set modelName(value) {
    _modelName = value;
  }

  get displayName => _displayName;

  set displayName(value) {
    _displayName = value;
  }

  String get brandId => _brandId;

  set brandId(String value) {
    _brandId = value;
  }

  static List<BeanVehicleModel> getDefaultModels()
  {
    List<BeanVehicleModel> _listVehicleModels = List.empty(growable: true);

    _listVehicleModels.add(BeanVehicleModel("0", Strings.selectVehicleModel+" *", Strings.selectVehicleModel+" *", "0"));

    return _listVehicleModels;
  }
}