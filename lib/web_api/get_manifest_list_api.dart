import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_manifest_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetManifestListAPI
{
  static Future<List<BeanManifestDetails>> getManifestList() async
  {
    List<BeanManifestDetails> listManifests = List.empty(growable: true);
    listManifests.clear();

    String url = URLHelper.wsGetManifestList;

    var client = http.Client();

    try
    {
      print("Getting Manifest List => "+ url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.post(
          Uri.parse(url),
        headers: header
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> citiesData = response['manifest'];
          for (int i=0; i<citiesData.length; i++)
          {
            String manifestId = citiesData[i]['id'] ?? "0";
            String truckerName = citiesData[i]['truckerName'] ?? "NA";
            String driverName = citiesData[i]['driverName'] ?? "NA";
            String vehicleNumber = citiesData[i]['vehicleNumber'] ?? "NA";
            String manifestDate = citiesData[i]['manifest_date'] ?? "NA";
            String manifestTime = citiesData[i]['manifest_time'] ?? "NA";
            String driverMobileNumber = citiesData[i]['driverMobNo'] ?? "NA";
            String routeName = citiesData[i]['routeName'] ?? "NA";
            String routeStartLocName = citiesData[i]['routeStartLocationName'] ?? "NA";
            String routeEndLocName = citiesData[i]['routeEndLocationName'] ?? "NA";

            BeanManifestDetails manifestDetails = BeanManifestDetails(
                manifestId, truckerName, driverName, vehicleNumber, manifestDate);
            manifestDetails.driverMobileNo = driverMobileNumber;
            manifestDetails.timeCreated = manifestTime;
            manifestDetails.routeName = routeName;
            manifestDetails.routeStartLocName = routeStartLocName;
            manifestDetails.routeEndLocName = routeEndLocName;

            listManifests.add(manifestDetails);
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listManifests;
  }
}