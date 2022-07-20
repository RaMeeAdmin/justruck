import 'package:justruck/beans/bean_driver_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:dio/dio.dart';

class AddDriverAPI
{
  static Future<bool> submitDriverDetails(BeanDriverDetails driverDetails) async
  {
    bool driverAdded = false;

    try
    {
      String url = URLHelper.wsAddDriver;
      print("Adding Driver => "+url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      FormData formData = FormData.fromMap({
        'trucker_id':'0',
        'name': driverDetails.driverName,
        'mobile':driverDetails.mobileNumber,
        'current_address_line_1': driverDetails.currentAddressLine1,
        'current_address_line_2': driverDetails.currentAddressLine2,
        'current_city_id': driverDetails.currentCityId,
        'current_district': driverDetails.currentDistrict,
        'current_state': driverDetails.currentState,
        'permanant_address_line_1': driverDetails.permanentAddressLine1,
        'permanant_address_line_2': driverDetails.permanentAddressLine2,
        'permanant_city_id': driverDetails.permanentCityId,
        'permanant_district': driverDetails.permanentDistrict,
        'permanant_state':driverDetails.permanentState,
        'aadhar': driverDetails.aadharNo,
        'license_number': driverDetails.drivingLicenseNo,
        'license_expiry_date': driverDetails.licesneExpiryDate,
        //'isVerified':'1',
        //'isActive':'1',
        'driver_image': driverDetails.driverImage.isEmpty ? '' : await MultipartFile.fromFile(driverDetails.driverImage),
        'aadhar_image': driverDetails.aadharImaage.isEmpty ? '' : await MultipartFile.fromFile(driverDetails.aadharImaage),
        'license_image': driverDetails.driverLicenseImageUrl.isEmpty ? '' : await MultipartFile.fromFile(driverDetails.driverLicenseImageUrl)
      });


      Dio dio = Dio();
      dio.options.headers = header;
      Response uriResponse = await dio.post(url, data: formData);
      print("reponse => "+uriResponse.toString());

      var response = uriResponse.data;
      if(response[CommonConstants.success] == true)
      {
        driverAdded = true;
      }
      else
      {
        driverAdded = false;
        var message = response[CommonConstants.message];
        CommonWidgets.showToast(message);
      }
    }
    finally
    {

    }

    return driverAdded;
  }
}