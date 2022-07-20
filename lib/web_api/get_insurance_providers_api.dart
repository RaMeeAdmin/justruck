import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_insurance_provider.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetInsuranceProvidersAPI
{
  static Future<List<BeanInsuranceProvider>> getProvidersList() async
  {
    List<BeanInsuranceProvider> listProviders = List.empty(growable: true);

    listProviders.clear();

    String url = URLHelper.wsGetInsuranceProviders;

    var client = http.Client();

    try
    {
      print("Getting Insurance Providers List => "+ url);

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
          List<dynamic> insProvidersData = response['insurance_providers'];
          for (int i=0; i<insProvidersData.length; i++)
          {
            String providerId = insProvidersData[i]['id'] ?? "00";
            String providerName = insProvidersData[i]['name'] ?? "NA";
            String displayName = insProvidersData[i]['display_name'] ?? "NA";

            listProviders.add(BeanInsuranceProvider(providerId, providerName, displayName));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listProviders;
  }
}