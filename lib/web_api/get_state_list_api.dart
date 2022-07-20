import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_state.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetStateListAPI
{
  static Future<List<BeanState>> getStatesList() async
  {
    List<BeanState> listStates = List.empty(growable: true);
    listStates.clear();

    String url = URLHelper.wsGetStateList;

    var client = http.Client();

    try
    {
      print("Getting States List => "+ url);
      var uriResponse = await client.get(Uri.parse(url));
      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> statesData = response['states'];
          for (int i=0; i<statesData.length; i++)
          {
            String stateCode = statesData[i]['state_code'] ?? "00";
            String stateName = statesData[i]['state_name'] ?? "NA";

            listStates.add(BeanState(stateCode, stateName));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listStates;
  }
}