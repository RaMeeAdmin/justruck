import 'package:geocoding/geocoding.dart';
import 'package:justruck/beans/bean_location_details.dart';
import 'package:location/location.dart' as loc;

class LocationHelper
{
  static Future<bool> checkLocationServiceEnableOrNot() async
  {
    bool enabled = false;

    loc.Location location = loc.Location();
    enabled = await location.serviceEnabled();

    return enabled;
  }

  static Future<bool> requestLocationService() async
  {
    bool requested = false;

    loc.Location location = loc.Location();
    requested = await location.requestService();

    return requested;
  }

  static Future<BeanLocationDetails> getDeviceLocation() async
  {
    print("Getting Location");
    BeanLocationDetails beanLocationDetails = BeanLocationDetails("0.0", "0.0", "");
    loc.Location location = loc.Location();
    loc.LocationData _locationData;

    bool enabled = await location.serviceEnabled();
    if(!enabled)
    {
      await location.requestService();
    }
    else
    {
      _locationData = await location.getLocation();
      double latitude = _locationData.latitude!;
      double longitude = _locationData.longitude!;

      beanLocationDetails.latitude = latitude.toString();
      beanLocationDetails.longitude = longitude.toString();

      List<Placemark> list = await placemarkFromCoordinates(latitude, longitude);

      String addr = list[0].street.toString()+", "
          +list[0].subLocality.toString()+", "
          +list[0].locality.toString()+", "
          +list[0].postalCode.toString();

      beanLocationDetails.address = addr;

      print("Address => "+addr);
    }

    return beanLocationDetails;
  }
}