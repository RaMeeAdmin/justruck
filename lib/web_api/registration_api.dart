import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class RegistrationAPI
{
  static Future<BeanResponse> registerTransporterOrTrucker(BeanRegistrationDetails regDetails) async
  {
    BeanResponse regResponse = BeanResponse(false, "", "");

    String url = URLHelper.wsRegistration;
    print("Registering => "+url);

    var client = http.Client();

    try
    {
      var uriResponse = await client.post(Uri.parse(url),
        body: {
        'user_type': regDetails.registrationFor,
        'username': regDetails.contactMobile,
        'password': regDetails.pin,
        'company_type':regDetails.companyType,
        'company_name': regDetails.companyName,
        'address_1': regDetails.addressLine1,
        'address_2': regDetails.addressLine2,
        'city_id':regDetails.companyCity,
        'state_id':regDetails.companyState,
        'pan': regDetails.companyPAN,
        'gstn':regDetails.companyGSTIN,

      /*'transporter_type':regDetails.transporterType,
        'bank_name':regDetails.bankName,
        'bank_ifsc':regDetails.bankIfscCode,
        'bank_account_number':regDetails.bankAccountNo,
        'bank_branch_name':regDetails.branchName,
        'subscription_type': regDetails.subscriptionTypeId,
        'isActive':'Y',
        'isDeleted':'N',*/

        'isVerified':'Y',

        'primary_contact_number':regDetails.contactMobile,
        'primary_contact_name':regDetails.contactName,
        'primary_contact_email':regDetails.contactEmail,
        'primary_contact_designation':regDetails.contactDesignation,
        'individual_aadhar_no':regDetails.individualAadharNo,

        'district_name':regDetails.districtName,
        'comapny_email':regDetails.companyEmail,
        'is_gst_registered':regDetails.isGSTRegistered,
        'whatsApp_mobile_no':regDetails.whatsAppMobileNo,
        'isHomeDeliveryProvided':regDetails.isHomeDeliveryProvided,
        'isInsuranceProvided':regDetails.isInsuranceProvided,
        }
      );

      print(uriResponse.body.toString());

      Map response = jsonDecode(uriResponse.body);
      if(response[CommonConstants.success]== true)
      {
        regResponse.success = true;
        regResponse.message = response[CommonConstants.message];
        regResponse.data = response['data'];
      }
      else
      {
        regResponse.success = false;
        regResponse.message = response[CommonConstants.message];
      }
    }
    finally
    {
      client.close();
    }

    return regResponse;
  }
}