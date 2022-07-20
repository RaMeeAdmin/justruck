import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetTransporterDetailsAPI
{
  static Future<List<BeanRegistrationDetails>> getTransporterDetailsFor(String cityId, String isHomeDeliveryProvided) async
  {
    List<BeanRegistrationDetails> _listTransporters = List.empty(growable: true);

    _listTransporters.clear();

    String url = URLHelper.wsGetTransporterDetails;

    var client = http.Client();

    try
    {
      print("Getting Transporter Details for CityId "+cityId+" and home delivery "+isHomeDeliveryProvided+" => "+ url);

      var uriResponse = await client.post(
          Uri.parse(url),
          body: {
            'city_id': cityId,
            'isHomeDeliveryProvided': isHomeDeliveryProvided,
        }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> transportersData = response['data'];
          for (int i=0; i<transportersData.length; i++)
          {
            String id = transportersData[i]['id'] ?? "00";
            String referenceCode = transportersData[i]['reference_code'] ?? "NA";
            String companyName = transportersData[i]['company_name'] ?? "NA";
            String addressLine1 = transportersData[i]['address_1'] ?? "NA";
            String addressLine2 = transportersData[i]['address_2'] ?? "NA";
            String city_id = transportersData[i]['city_id'] ?? "NA";
            String stateCode = transportersData[i]['state_id'] ?? "NA";
            String primary_contact_number = transportersData[i]['primary_contact_number'] ?? "NA";
            String isHomeDeliveryProvided = transportersData[i]['isHomeDeliveryProvided'] ?? "N";

            BeanRegistrationDetails transporterDetails = BeanRegistrationDetails();
            transporterDetails.transporterOrTruckerId = id;
            transporterDetails.companyName = companyName;
            transporterDetails.addressLine1 = addressLine1;
            transporterDetails.addressLine2 = addressLine2;
            transporterDetails.companyCity = city_id;
            transporterDetails.companyState = stateCode;
            transporterDetails.contactMobile = primary_contact_number;
            transporterDetails.isHomeDeliveryProvided = isHomeDeliveryProvided;

            _listTransporters.add(transporterDetails);
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return _listTransporters;
  }
}