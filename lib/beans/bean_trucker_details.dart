import 'package:justruck/other/strings.dart';

class BeanTruckerDetails
{
  String _truckerId = "";
  String _truckerName = "";


  BeanTruckerDetails(this._truckerId, this._truckerName);


  String get truckerId => _truckerId;

  set truckerId(String value) {
    _truckerId = value;
  }

  String get truckerName => _truckerName;

  set truckerName(String value) {
    _truckerName = value;
  }

  static List<BeanTruckerDetails> getDefaultTruckerList()
  {
    List<BeanTruckerDetails> listVehicleDetails = List.empty(growable: true);

    listVehicleDetails.add(BeanTruckerDetails("0", Strings.selectTrucker));

    return listVehicleDetails;
  }
}