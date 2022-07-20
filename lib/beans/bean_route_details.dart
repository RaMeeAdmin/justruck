import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/other/strings.dart';

class BeanRouteDetails
{
  String _routeId = "", _routeName = "";
  String _startLocationId = "", _endLocationId = "";
  String _startLocationName = "", _endLocationName = "";
  String _routeType = "", _radiusInKM = "";
  List<BeanIdValue> _listIntermediateLocations = List.empty(growable: true);

  BeanRouteDetails(this._routeId, this._routeName, this._startLocationId, this._endLocationId);

  get endLocationId => _endLocationId;

  set endLocationId(value) {
    _endLocationId = value;
  }

  String get startLocationId => _startLocationId;

  set startLocationId(String value) {
    _startLocationId = value;
  }

  get routeName => _routeName;

  set routeName(value) {
    _routeName = value;
  }

  String get routeId => _routeId;

  set routeId(String value) {
    _routeId = value;
  }


  String get startLocationName => _startLocationName;

  set startLocationName(String value) {
    _startLocationName = value;
  }

  get endLocationName => _endLocationName;

  set endLocationName(value) {
    _endLocationName = value;
  }

  String get routeType => _routeType;

  set routeType(String value) {
    _routeType = value;
  }

  get radiusInKM => _radiusInKM;

  set radiusInKM(value) {
    _radiusInKM = value;
  }

  List<BeanIdValue> get listIntermediateLocations => _listIntermediateLocations;

  set listIntermediateLocations(List<BeanIdValue> value) {
    _listIntermediateLocations = value;
  }

  static List<BeanRouteDetails> getDefaultRoutes()
  {
    List<BeanRouteDetails> _listRoutes = List.empty(growable: true);

    _listRoutes.add(BeanRouteDetails("0", Strings.selectRoute+" *", "" , ""));

    return _listRoutes;
  }
}