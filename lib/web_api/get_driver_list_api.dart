import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_driver_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetDriverListAPI
{
  static Future<List<BeanDriverDetails>> getDriverDetailsList() async
  {
    List<BeanDriverDetails> listDrivers = List.empty(growable: true);
    listDrivers.clear();

    String url = URLHelper.wsListDrivers;

    var client = http.Client();

    try
    {
      print("Getting Drivers List => "+ url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.get(
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
          List<dynamic> citiesData = response['driver_details'];
          for (int i=0; i<citiesData.length; i++)
          {
            String id = citiesData[i]['id'] ?? "0";
            String driverName = citiesData[i]['name'] ?? "NA";
            String mobileNumber = citiesData[i]['mobile'] ?? "NA";
            String currentAddressLine1 = citiesData[i]['current_address_line_1'] ?? "NA";
            String assignedVehicle = citiesData[i]['vehicle_no'] ?? "NA";
            String driverImage = citiesData[i]['driver_image'] ?? "NA";

            BeanDriverDetails driverDetails = BeanDriverDetails(id, driverName, mobileNumber, currentAddressLine1, assignedVehicle, driverImage);

            listDrivers.add(driverDetails);
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listDrivers;
  }
}