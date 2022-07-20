import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

class PermissionHelper
{
  static Future<bool> checkLocationPermission() async
  {
    //bool granted = await Permission.location.isGranted;
    //return granted;

    loc.Location location = loc.Location();
    bool granted = false;
    loc.PermissionStatus _permissionStatus = await location.hasPermission();
    if(_permissionStatus==loc.PermissionStatus.granted)
    {
      granted = true;
    }
    else
    {
      granted = false;
    }

    return granted;
  }

  static Future<bool> requestLocationPermission() async
  {
    /*Permission _permission = Permission.location;
    PermissionStatus status = await _permission.request();
    if(status.isGranted) {
      return true;
    }
    else {
      return false;
    }*/

    loc.Location location = loc.Location();
    loc.PermissionStatus _permissionStatus = await location.requestPermission();
    if(_permissionStatus==loc.PermissionStatus.granted)
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  /*------------------------------------------------------------------*/

  static Future<bool> checkStoragePermission() async
  {
    bool granted = await Permission.storage.isGranted;
    return granted;
  }

  static Future<bool> requestStoragePermission() async
  {
    Permission _permission = Permission.storage;
    PermissionStatus status = await _permission.request();
    if(status.isGranted) {
      return true;
    }
    else {
      return false;
    }
  }
}