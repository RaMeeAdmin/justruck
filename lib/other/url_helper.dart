class URLHelper
{
  //static String baseApiURL = "https://justruck.ramatechno.com/api/";
  static String baseApiURL = "https://justruck.com/api/";

  static String wsGetStateList = baseApiURL+"ws-get-state";
  static String wsGetCityList = baseApiURL+"ws-get-city";
  static String wsGetCityListByName = baseApiURL+"ws-search_city";
  static String wsGetCompanyTypes = baseApiURL+"ws-get-company-type";
  static String wsGetSubscriptionTypes = baseApiURL+"ws-get-subscription-types";
  static String wsGetDesignationList = baseApiURL+"ws-get-designation";

  static String wsRegistration = baseApiURL+"transporter_register";
  static String wsVerifyOTP = baseApiURL+"ws-verify-otp";
  static String wsLogin = baseApiURL+"login";
  static String wsForgotPin = baseApiURL+"ws-forgot-password";

  static String wsSendOTP = baseApiURL+"ws-send-otp"; // this api used while registration
  static String wsResendOTP = baseApiURL+"ws-resend-otp"; // this api used if OTP did not received and user wish it to be resent

  static String wsAddRoute = baseApiURL+"ws-add-route";
  static String wsListRoute = baseApiURL+"ws-get-route-list";

  static String wsGetItemTypes = baseApiURL+"ws-get-item-types";

  static String wsAddParcel = baseApiURL+"ws-add-parcel";
  static String wsAddParcelNew = baseApiURL+"ws-add-parcel2"; // added different payment modes

  static String wsListParcel = baseApiURL+"ws-parcel-list";
  static String wsRouteWiseListParcel = baseApiURL+"ws-get-routewise-parcel-list";

  static String wsGetInsuranceProviders = baseApiURL+"ws-get-insurance-provider";
  static String wsGetVehicleBrands = baseApiURL+"ws-get-vehicle-brand";
  static String wsGetVehicleModels = baseApiURL+"ws-get-vehicle-model";
  static String wsAddCustomerDetails = baseApiURL+"ws-add-customer-details";
  static String wsSearchCustomer = baseApiURL+"ws-search-customer";
  static String wsCustomerList = baseApiURL+"ws-customer-list";

  static String wsGetLicenseType = baseApiURL+"ws-get-license-types";
  static String wsAddDriver = baseApiURL+"ws-add-driver";
  static String wsListDrivers = baseApiURL+"ws-driverList";
  static String wsListVehicles = baseApiURL+"ws-get-vehicle-list";

  static String wsGetRtoList = baseApiURL+"ws-get-rto-list";
  static String wsAddVehicle = baseApiURL+"ws-add-vehicle";

  static String wsAddManifest = baseApiURL+"ws-generate-manifest";
  static String wsSaveParcelTrack = baseApiURL+"ws-save-parcels-track";
  static String wsGetManifestList = baseApiURL+"ws-get-manifest-list";
  static String wsGetManifestDetails = baseApiURL+"ws-get-manifest-details";
  static String wsGetParcelDetails = baseApiURL+"ws-get-parcel-details";
  static String wsGetParcelTrack = baseApiURL+"ws-get-parcel-track";
  static String wsParcelDelivery = baseApiURL+"ws-parcel-delivery";

  static String wsChangePin = baseApiURL+"ws-get-change-user-pin";

  static String wsGetTransporterDetails = baseApiURL+"ws-get-transporter-details";
  static String wsMarkParcelReceived = baseApiURL+"ws-get-received-parcel";
  static String wsRemoveParcelFromManifest = baseApiURL+"ws-remove-parcel-from-manifest";

  static String wsGetStatisticsData = baseApiURL+"ws-get-stats-data";
  static String wsUpdatePayDetails = baseApiURL+"ws-update-pay-details";
}