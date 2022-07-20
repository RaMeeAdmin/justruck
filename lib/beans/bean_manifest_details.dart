import 'package:justruck/beans/bean_parcel_details.dart';

class BeanManifestDetails
{
  String _manifestId = "";
  String _vehicleNumber = "", _vehicleId = "";
  String _truckerName = "", _driverName = "", _driverMobileNo = "";
  String  _manifestDate = "", _timeCreated = "";
  String _routeName = "", _routeId = "", _routeStartLocName = "", _routeEndLocName = "";

  List<BeanParcelDetails> _listParcelDetails = List.empty(growable: true);

  BeanManifestDetails(this._manifestId, this._truckerName, this._driverName, this._vehicleNumber, this._manifestDate);

  String get manifestId => _manifestId;

  set manifestId(String value) {
    _manifestId = value;
  }

  String get truckerName => _truckerName;

  set truckerName(String value) {
    _truckerName = value;
  }

  get driverName => _driverName;

  set driverName(value) {
    _driverName = value;
  }

  String get vehicleNumber => _vehicleNumber;

  set vehicleNumber(String value) {
    _vehicleNumber = value;
  }

  get manifestDate => _manifestDate;

  set manifestDate(value) {
    _manifestDate = value;
  }




  String get routeName => _routeName;

  set routeName(String value) {
    _routeName = value;
  }

  get driverMobileNo => _driverMobileNo;

  set driverMobileNo(value) {
    _driverMobileNo = value;
  }

  get timeCreated => _timeCreated;

  set timeCreated(value) {
    _timeCreated = value;
  }

  List<BeanParcelDetails> get listParcelDetails => _listParcelDetails;

  set listParcelDetails(List<BeanParcelDetails> value) {
    _listParcelDetails = value;
  }

  get routeId => _routeId;

  set routeId(value) {
    _routeId = value;
  }

  get vehicleId => _vehicleId;

  set vehicleId(value) {
    _vehicleId = value;
  }

  get routeStartLocName => _routeStartLocName;

  set routeStartLocName(value) {
    _routeStartLocName = value;
  }

  get routeEndLocName => _routeEndLocName;

  set routeEndLocName(value) {
    _routeEndLocName = value;
  }

  static List<BeanManifestDetails> getDefaultManifestList()
  {
    List<BeanManifestDetails> listManifestDetails = List.empty(growable: true);

    BeanManifestDetails mfst1 = BeanManifestDetails("1", "Trucker 1", "Tukaram J.", "MH12 GC 5677", "12-Nov-2021");
    mfst1.routeName = "Pune Mumbai Daily Seva";
    mfst1.driverMobileNo = "9545632145";
    mfst1.timeCreated = "12:15 PM";

    BeanManifestDetails mfst2 = BeanManifestDetails("2", "Trucker 2", "Sakharam B.", "MH12 GC 1232", "13-Nov-2021");
    mfst2.routeName = "Nagpur Mumbai Weekly Seva";
    mfst2.driverMobileNo = "9541236545";
    mfst2.timeCreated = "12:17 PM";

    BeanManifestDetails mfst3 = BeanManifestDetails("3", "Trucker 3", "Vikas M.", "MH12 GC 7268", "13-Nov-2021");
    mfst3.routeName = "Pune Aurangabaad";
    mfst3.driverMobileNo = "8654865486";
    mfst3.timeCreated = "12:25 PM";

    BeanManifestDetails mfst4 = BeanManifestDetails("4", "Trucker 4", "Avinash K.", "MH12 GC 7693", "14-Nov-2021");
    mfst4.routeName = "Pune - Nagar Shuttle";
    mfst4.driverMobileNo = "8787858589";
    mfst4.timeCreated = "12:35 PM";


    listManifestDetails.add(mfst1);
    listManifestDetails.add(mfst2);
    listManifestDetails.add(mfst3);
    listManifestDetails.add(mfst4);

    return listManifestDetails;
  }
}