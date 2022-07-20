import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_designation_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetDesignationListAPI
{
  static Future<List<BeanDesignationDetails>> getDesignationDetailsList() async
  {
    List<BeanDesignationDetails> listDesignations = List.empty(growable: true);
    listDesignations.clear();

    String url = URLHelper.wsGetDesignationList;

    var client = http.Client();

    try
    {
      print("Getting Designation List => "+ url);
      var uriResponse = await client.get(Uri.parse(url));
      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> designationData = response['data'];
          for (int i=0; i<designationData.length; i++)
          {
            String designationId = designationData[i]['id'] ?? "00";
            String designationName = designationData[i]['name'] ?? "NA";

            listDesignations.add(BeanDesignationDetails(designationId, designationName));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listDesignations;
  }
}