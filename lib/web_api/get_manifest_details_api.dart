import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_manifest_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_route_details.dart';
import 'package:justruck/beans/bean_state.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetManifestDetailsAPI
{
  static Future<BeanManifestDetails> getManifestDetailsFor(String manifestId) async
  {
    BeanManifestDetails beanManifestDetails = BeanManifestDetails("", "", "", "", "");

    String url = URLHelper.wsGetManifestDetails;

    var client = http.Client();

    try
    {
      print("Getting Manifest Details => "+ url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.post(Uri.parse(url),
          headers: header,
          body: {
            'manifest_id': manifestId
          }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          Map manifestData = response['manifest'];
          String id = manifestData['id'] ?? "";
          String date = manifestData['manifest_date'] ?? "";
          String time = manifestData['manifest_time'] ?? "";
          String routeId = manifestData['route_id'] ?? "";
          String routeEndLocName = manifestData['routeEndLocationName'] ?? "";
          String routeStartLocName = manifestData['routeStartLocationName'] ?? "";
          String truckerId = manifestData['trucker_id'] ?? "";
          String vehicleId = manifestData['vehicle_id'] ?? "";
          String routeName = manifestData['routeName'] ?? "";
          String truckerName = manifestData['truckerName'] ?? "";
          String vehicleNumber = manifestData['vehicleNumber'] ?? "";
          String driverName = manifestData['driverName'] ?? "";
          String driverMobileNo = manifestData['driverMobNo'] ?? "";

          List<BeanParcelDetails> _listParcelDetails = List.empty(growable: true);

          List<dynamic> parcelData = manifestData['parcel_iteam'];
          for (int i=0; i<parcelData.length; i++)
          {
            String parcelId = parcelData[i]['id'] ?? "";
            String parcelBookingDate = parcelData[i]['booking_date'] ?? "";
            String senderName = parcelData[i]['from_name'] ?? "";
            String receiverName = parcelData[i]['to_name'] ?? "";
            String senderCityName = parcelData[i]['senderCityName'] ?? "";
            String receiverCityName = parcelData[i]['receiverCityName'] ?? "";
            String parcelStatus = parcelData[i]['status'] ?? "";;

            BeanParcelDetails beanParcelDetails = BeanParcelDetails(parcelId, parcelBookingDate, senderName, receiverName,
                senderCityName.trim(), receiverCityName.trim(), parcelStatus);
            _listParcelDetails.add(beanParcelDetails);
          }

          beanManifestDetails = BeanManifestDetails(id, truckerName, driverName, vehicleNumber, date);
          beanManifestDetails.routeStartLocName = routeStartLocName;
          beanManifestDetails.routeEndLocName = routeEndLocName;
          beanManifestDetails.driverMobileNo = driverMobileNo;

          beanManifestDetails.listParcelDetails = _listParcelDetails;
        }
      }
    }
    finally
    {
      client.close();
    }

    return beanManifestDetails;
  }
}