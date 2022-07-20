import 'package:justruck/beans/bean_driver_details.dart';
import 'package:justruck/beans/bean_vehicle_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:dio/dio.dart';

class AddVehicleAPI
{
  static Future<bool> submitVehicleDetails(BeanVehicleDetails vehicleDetails) async
  {
    bool vehicleAdded = false;

    try
    {
      String url = URLHelper.wsAddVehicle;
      print("Adding Vehicle => "+url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      FormData formData = FormData.fromMap({
        'brand_id':vehicleDetails.vehicleBrandId,
        'model_id': vehicleDetails.vehicleModelId,
        'rto_id': vehicleDetails.rtoId,
        'registration_number_part_2': vehicleDetails.part2,
        'registration_number_part_3': vehicleDetails.part3,
        'vehicle_number': vehicleDetails.vehicleNumber,
        'insurance_provider_id': vehicleDetails.insuranceProviderId,
        'insurance_number': vehicleDetails.insuranceNumber,
        'insurance_valid_from': vehicleDetails.insuranceValidFrom,
        'insurance_valid_till': vehicleDetails.insuranceValidTill,
        'storage_lbh': vehicleDetails.volume,
        'length': vehicleDetails.length,
        'breadth': vehicleDetails.breadth,
        'height': vehicleDetails.height,
        'no_of_tyres': vehicleDetails.numberOfTyres,
        'max_load_capacity': vehicleDetails.loadCapacity,
        'route_id': '1',
        'isActive': '1',
        'chassis_number':vehicleDetails.chassisNumber,
        'body_type': vehicleDetails.bodyType,
        'assigned_driver_id': vehicleDetails.assignedDriver,
        'insurance_image': vehicleDetails.insuranceImage.isEmpty ? '' : await MultipartFile.fromFile(vehicleDetails.insuranceImage),
        'image': vehicleDetails.vehicleImage.isEmpty ? '' : await MultipartFile.fromFile(vehicleDetails.vehicleImage),
      });

      Dio dio = Dio();
      dio.options.headers = header;
      Response uriResponse = await dio.post(url, data: formData);
      print("response => "+uriResponse.toString());

      var response = uriResponse.data;
      if(response[CommonConstants.success] == true)
      {
        vehicleAdded = true;
      }
      else
      {
        vehicleAdded = false;
        var message = response[CommonConstants.message];
        CommonWidgets.showToast(message);
      }
    }
    finally
    {

    }

    return vehicleAdded;
  }
}