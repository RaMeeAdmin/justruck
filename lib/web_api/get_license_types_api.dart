import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_license_type.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetLicenseTypesAPI
{
  static Future<List<BeanLicenseType>> retrieveLicenseTypesList() async
  {
    List<BeanLicenseType> listLicenseTypes = List.empty(growable: true);

    listLicenseTypes.clear();

    String url = URLHelper.wsGetLicenseType;
    var client = http.Client();

    try
    {
      print("Getting License Types => "+ url);

      var uriResponse = await client.get(
          Uri.parse(url),
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> insProvidersData = response['details'];
          for (int i=0; i<insProvidersData.length; i++)
          {
            String id = insProvidersData[i]['id'] ?? "00";
            String name = insProvidersData[i]['name'] ?? "NA";
            String displayName = insProvidersData[i]['display_name'] ?? "NA";

            listLicenseTypes.add(BeanLicenseType(id, name, displayName));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listLicenseTypes;
  }
}