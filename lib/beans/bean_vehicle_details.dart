import 'package:justruck/other/strings.dart';

class BeanVehicleDetails
{
  String _vehicleId = "";
  String _vehicleNumber = "";
  String _rtoId = "", _part2 = "", _part3 = "";
  String _chassisNumber = "";
  String _vehicleBrandId = "", _vehicleModelId = "";
  String _vehicleBrandName = "", _vehicleModelName = "";
  String _loadCapacity = "", _bodyType = "", _numberOfTyres = "";
  String _insuranceProviderId = "", _insuranceNumber = "", _insuranceValidFrom = "", _insuranceValidTill = "";
  String _insuranceImage = "", _vehicleImage = "";

  String _volume = "", _length= "", _breadth = "", _height = "";

  String _assignedDriver = "";

  BeanVehicleDetails(this._vehicleId, this._vehicleNumber);

  String get assignedDriver => _assignedDriver;

  set assignedDriver(String value) {
    _assignedDriver = value;
  }

  get height => _height;

  set height(value) {
    _height = value;
  }

  get breadth => _breadth;

  set breadth(value) {
    _breadth = value;
  }

  get length => _length;

  set length(value) {
    _length = value;
  }

  String get volume => _volume;

  set volume(String value) {
    _volume = value;
  }

  get vehicleImage => _vehicleImage;

  set vehicleImage(value) {
    _vehicleImage = value;
  }

  String get insuranceImage => _insuranceImage;

  set insuranceImage(String value) {
    _insuranceImage = value;
  }

  get insuranceValidTill => _insuranceValidTill;

  set insuranceValidTill(value) {
    _insuranceValidTill = value;
  }

  get insuranceValidFrom => _insuranceValidFrom;

  set insuranceValidFrom(value) {
    _insuranceValidFrom = value;
  }

  get insuranceNumber => _insuranceNumber;

  set insuranceNumber(value) {
    _insuranceNumber = value;
  }

  String get insuranceProviderId => _insuranceProviderId;

  set insuranceProviderId(String value) {
    _insuranceProviderId = value;
  }

  get numberOfTyres => _numberOfTyres;

  set numberOfTyres(value) {
    _numberOfTyres = value;
  }

  get bodyType => _bodyType;

  set bodyType(value) {
    _bodyType = value;
  }

  String get loadCapacity => _loadCapacity;

  set loadCapacity(String value) {
    _loadCapacity = value;
  }

  get vehicleModelName => _vehicleModelName;

  set vehicleModelName(value) {
    _vehicleModelName = value;
  }

  String get vehicleBrandName => _vehicleBrandName;

  set vehicleBrandName(String value) {
    _vehicleBrandName = value;
  }

  get vehicleModelId => _vehicleModelId;

  set vehicleModelId(value) {
    _vehicleModelId = value;
  }

  String get vehicleBrandId => _vehicleBrandId;

  set vehicleBrandId(String value) {
    _vehicleBrandId = value;
  }

  String get chassisNumber => _chassisNumber;

  set chassisNumber(String value) {
    _chassisNumber = value;
  }

  get part3 => _part3;

  set part3(value) {
    _part3 = value;
  }

  get part2 => _part2;

  set part2(value) {
    _part2 = value;
  }

  String get rtoId => _rtoId;

  set rtoId(String value) {
    _rtoId = value;
  }

  String get vehicleNumber => _vehicleNumber;

  set vehicleNumber(String value) {
    _vehicleNumber = value;
  }

  String get vehicleId => _vehicleId;

  set vehicleId(String value) {
    _vehicleId = value;
  }

  static List<BeanVehicleDetails> getDefaultVehicleList()
  {
    List<BeanVehicleDetails> listVehicleDetails = List.empty(growable: true);

    listVehicleDetails.add(BeanVehicleDetails("0", Strings.selectVehicle+" *"));

    return listVehicleDetails;
  }
}