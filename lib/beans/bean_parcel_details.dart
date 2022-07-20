import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_parcel_item_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';

class BeanParcelDetails
{
  String _parcelId = "", _receiptNumber = "";
  String _parcelBookingType = "";
  String _senderName = "", _senderMobile = "", _senderCityId ="", _senderCityName = "", _senderAddress = "";
  String _receiverName = "", _receiverMobile = "", _receiverCityId ="", _receiverCityName = "", _receiverAddress = "";
  String _parcelBookingDate = "";
  String _insuranceRequired = "", _insurancePercentage = "", _insuranceCharges = "", _insuranceProviderId = "";
  String _totalWeight = "", _totalVolume = "", _totalDeclaredValue = "";
  String _parcelCharges = "";
  String _cgstCharges = "", _sgstCharges = "", _totalGSTCharges = "";
  String _paymentStatus = "", _paymentMode = "";
  String _totalAmount = "";
  String _tenderedAmount = "", _changeReturn = "";
  String _parcelStatus = "";
  String _homeDeliveryRequired = "";
  String _receiptURL = "", _qrCodeURL = "";

  String _receivingTransporterId = "", _recievingTransporterName = "", _recievingTransporterAddress = "", _isReceived = "";

  List<BeanParcelItemDetails> _listParcelItems = List.empty(growable: true);
  List<BeanIdValue> _listPaymentDetails = List.empty(growable: true);

  bool _checked = false; // for manifest generation
  bool _isSelected = false; // for making parcel "In-transit" in drivers login
  String _isScanned = ""; // for indicating parcel was scanned from scan QR code option in any login
  String _trackDescription = "";
  String _assignedDriverId = "";

  BeanParcelDetails.empty();

  BeanParcelDetails(
      this._parcelId,
      this._parcelBookingDate,
      this._senderName,
      this._receiverName,
      this._senderCityName,
      this._receiverCityName,
      this._parcelStatus);

  get receiptNumber => _receiptNumber;

  set receiptNumber(value) {
    _receiptNumber = value;
  }

  String get parcelStatus => _parcelStatus;

  set parcelStatus(String value) {
    _parcelStatus = value;
  }

  get insuranceCharges => _insuranceCharges;

  set insuranceCharges(value) {
    _insuranceCharges = value;
  }

  get insurancePercentage => _insurancePercentage;

  set insurancePercentage(value) {
    _insurancePercentage = value;
  }

  String get insuranceRequired => _insuranceRequired;

  set insuranceRequired(String value) {
    _insuranceRequired = value;
  }

  String get parcelBookingDate => _parcelBookingDate;

  set parcelBookingDate(String value) {
    _parcelBookingDate = value;
  }

  get receiverAddress => _receiverAddress;

  set receiverAddress(value) {
    _receiverAddress = value;
  }

  get receiverCityName => _receiverCityName;

  set receiverCityName(value) {
    _receiverCityName = value;
  }

  get receiverCityId => _receiverCityId;

  set receiverCityId(value) {
    _receiverCityId = value;
  }

  get receiverMobile => _receiverMobile;

  set receiverMobile(value) {
    _receiverMobile = value;
  }

  String get receiverName => _receiverName;

  set receiverName(String value) {
    _receiverName = value;
  }

  get senderAddress => _senderAddress;

  set senderAddress(value) {
    _senderAddress = value;
  }

  get senderCityName => _senderCityName;

  set senderCityName(value) {
    _senderCityName = value;
  }

  get senderCityId => _senderCityId;

  set senderCityId(value) {
    _senderCityId = value;
  }

  get senderMobile => _senderMobile;

  set senderMobile(value) {
    _senderMobile = value;
  }

  String get senderName => _senderName;

  set senderName(String value) {
    _senderName = value;
  }

  String get parcelBookingType => _parcelBookingType;

  set parcelBookingType(String value) {
    _parcelBookingType = value;
  }

  String get parcelId => _parcelId;

  set parcelId(String value) {
    _parcelId = value;
  }


  String get parcelCharges => _parcelCharges;

  set parcelCharges(String value) {
    _parcelCharges = value;
  }

  get paymentStatus => _paymentStatus;

  set paymentStatus(value) {
    _paymentStatus = value;
  }

  get paymentMode => _paymentMode;

  set paymentMode(value) {
    _paymentMode = value;
  }

  List<BeanParcelItemDetails> get listParcelItems => _listParcelItems;

  set listParcelItems(List<BeanParcelItemDetails> value) {
    _listParcelItems = value;
  }


  String get totalWeight => _totalWeight;

  set totalWeight(String value) {
    _totalWeight = value;
  }

  get totalVolume => _totalVolume;

  set totalVolume(value) {
    _totalVolume = value;
  }

  get insuranceProviderId => _insuranceProviderId;

  set insuranceProviderId(value) {
    _insuranceProviderId = value;
  }

  bool get checked => _checked;

  set checked(bool value) {
    _checked = value;
  }

  get cgstCharges => _cgstCharges;

  set cgstCharges(value) {
    _cgstCharges = value;
  }

  get sgstCharges => _sgstCharges;

  set sgstCharges(value) {
    _sgstCharges = value;
  }

  get totalGSTCharges => _totalGSTCharges;

  set totalGSTCharges(value) {
    _totalGSTCharges = value;
  }

  get totalDeclaredValue => _totalDeclaredValue;

  set totalDeclaredValue(value) {
    _totalDeclaredValue = value;
  }


  String get totalAmount => _totalAmount;

  set totalAmount(String value) {
    _totalAmount = value;
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }


  String get isScanned => _isScanned;

  set isScanned(String value) {
    _isScanned = value;
  }

  String get trackDescription => _trackDescription;

  set trackDescription(String value) {
    _trackDescription = value;
  }

  String get receivingTransporterId => _receivingTransporterId;

  set receivingTransporterId(String value) {
    _receivingTransporterId = value;
  }

  String get homeDeliveryRequired => _homeDeliveryRequired;

  set homeDeliveryRequired(String value) {
    _homeDeliveryRequired = value;
  }

  get isReceived => _isReceived;

  set isReceived(value) {
    _isReceived = value;
  }

  get recievingTransporterAddress => _recievingTransporterAddress;

  set recievingTransporterAddress(value) {
    _recievingTransporterAddress = value;
  }

  get recievingTransporterName => _recievingTransporterName;

  set recievingTransporterName(value) {
    _recievingTransporterName = value;
  }

  get qrCodeURL => _qrCodeURL;

  set qrCodeURL(value) {
    _qrCodeURL = value;
  }

  String get receiptURL => _receiptURL;

  set receiptURL(String value) {
    _receiptURL = value;
  }

  get changeReturn => _changeReturn;

  set changeReturn(value) {
    _changeReturn = value;
  }

  String get tenderedAmount => _tenderedAmount;

  set tenderedAmount(String value) {
    _tenderedAmount = value;
  }


  List<BeanIdValue> get listPaymentDetails => _listPaymentDetails;

  set listPaymentDetails(List<BeanIdValue> value) {
    _listPaymentDetails = value;
  }


  String get assignedDriverId => _assignedDriverId;

  set assignedDriverId(String value) {
    _assignedDriverId = value;
  }

  static List<BeanParcelDetails> getDefaultParcelList()
  {
    List<BeanParcelDetails> listParcelDetails = List.empty(growable: true);

    listParcelDetails.add(BeanParcelDetails("P-11123", "2021-11-16","Suraj B","Ravi H.", "Pune", "Nanded", "1"));
    listParcelDetails.add(BeanParcelDetails("P-11152", "2021-11-16","K.C.","Yogesh J.", "Pune", "Sangamner", "2"));
    listParcelDetails.add(BeanParcelDetails("P-11489", "2021-11-16","Shubhangi L.","Jyostna K.", "Pune", "Aurangabaad", "2"));
    listParcelDetails.add(BeanParcelDetails("P-11490", "2021-11-16","Ravi. H","Suraj B.", "Nanded", "Pune", "1"));
    listParcelDetails.add(BeanParcelDetails("P-11756", "2021-11-16","Yogesh J.","K.C.", "Sangamner", "Pune", "3"));
    listParcelDetails.add(BeanParcelDetails("P-11758", "2021-11-16","Jyostna K.","Shubhangi L.", "Aurangabaad", "Pune", "1"));

    return listParcelDetails;
  }

  static List<BeanParcelDetails> getBookedParcelList()
  {
    List<BeanParcelDetails> listParcelDetails = List.empty(growable: true);

    listParcelDetails.add(BeanParcelDetails("P-11123", "2021-11-16","Suraj B","Ravi H.", "Pune", "Nanded", "1"));
    listParcelDetails.add(BeanParcelDetails("P-11152", "2021-11-16","K.C.","Yogesh J.", "Pune", "Sangamner", "1"));
    listParcelDetails.add(BeanParcelDetails("P-11489", "2021-11-16","Shubhangi L.","Jyostna K.", "Pune", "Aurangabaad", "1"));
    listParcelDetails.add(BeanParcelDetails("P-11490", "2021-11-16","Ravi. H","Suraj B.", "Nanded", "Pune", "1"));
    listParcelDetails.add(BeanParcelDetails("P-11756", "2021-11-16","Yogesh J.","K.C.", "Sangamner", "Pune", "1"));
    listParcelDetails.add(BeanParcelDetails("P-11758", "2021-11-16","Jyostna K.","Shubhangi L.", "Aurangabaad", "Pune", "1"));

    return listParcelDetails;
  }

  static String getParcelStatusString(String parcelStatus)
  {
    String statusString = "NA";
    if(parcelStatus.toLowerCase()==CommonConstants.statusBooked) {
      statusString = Strings.booked;
    }
    else if(parcelStatus.toLowerCase()==CommonConstants.statusInTransit) {
      statusString = Strings.inTransit;
    }
    else if(parcelStatus.toLowerCase()==CommonConstants.statusScanned) {
      statusString = Strings.scanned;
    }
    else if(parcelStatus.toLowerCase()==CommonConstants.statusReceived) {
      statusString = Strings.received;
    }
    else if(parcelStatus.toLowerCase()==CommonConstants.statusDelivered) {
      statusString = Strings.delivered;
    }

    return statusString;
  }

  static String getBookingTypeString(String bookingType)
  {
    String statusString = "NA";
    if(bookingType.toLowerCase()==CommonConstants.payStatusPaid.toLowerCase()) {
      statusString = Strings.paidBooking;
    }
    else if(bookingType.toLowerCase()==CommonConstants.payStatusToPay.toLowerCase()) {
      statusString = Strings.toPayBooking;
    }

    return statusString;
  }

  static BeanParcelDetails copyParcelDetails(BeanParcelDetails parcelDetails)
  {
    BeanParcelDetails copiedDetails = BeanParcelDetails.empty();

    copiedDetails.parcelId = parcelDetails.parcelId;

    copiedDetails.receiptNumber = parcelDetails.receiptNumber;
    copiedDetails.parcelBookingType = parcelDetails.parcelBookingType;
    copiedDetails.senderName = parcelDetails.senderName;
    copiedDetails.senderMobile = parcelDetails.senderMobile;
    copiedDetails.senderCityId = parcelDetails.senderCityId;
    copiedDetails.senderCityName = parcelDetails.senderCityName;
    copiedDetails.senderAddress = parcelDetails.senderAddress;
    copiedDetails.receiverName = parcelDetails.receiverName;
    copiedDetails.receiverMobile = parcelDetails.receiverMobile;
    copiedDetails.receiverCityId = parcelDetails.receiverCityId;

    copiedDetails.receiverCityName = parcelDetails.receiverCityName;
    copiedDetails.receiverAddress = parcelDetails.receiverAddress;
    copiedDetails.parcelBookingDate = parcelDetails.parcelBookingDate;
    copiedDetails.insuranceRequired = parcelDetails.insuranceRequired;
    copiedDetails.insurancePercentage = parcelDetails.insurancePercentage;
    copiedDetails.insuranceCharges = parcelDetails.insuranceCharges;
    copiedDetails.insuranceProviderId = parcelDetails.insuranceProviderId;
    copiedDetails.totalWeight = parcelDetails.totalWeight;
    copiedDetails.totalVolume = parcelDetails.totalVolume;
    copiedDetails.totalDeclaredValue = parcelDetails.totalDeclaredValue;

    copiedDetails.parcelCharges = parcelDetails.parcelCharges;
    copiedDetails.cgstCharges = parcelDetails.cgstCharges;
    copiedDetails.sgstCharges = parcelDetails.sgstCharges;
    copiedDetails.totalGSTCharges = parcelDetails.totalGSTCharges;
    copiedDetails.paymentStatus = parcelDetails.paymentStatus;
    copiedDetails.paymentMode = parcelDetails.paymentMode;
    copiedDetails.totalAmount = parcelDetails.totalAmount;
    copiedDetails.tenderedAmount = parcelDetails.tenderedAmount;
    copiedDetails.changeReturn = parcelDetails.changeReturn;
    copiedDetails.parcelStatus = parcelDetails.parcelStatus;

    copiedDetails.homeDeliveryRequired = parcelDetails.homeDeliveryRequired;
    copiedDetails.receiptURL = parcelDetails.receiptURL;
    copiedDetails.qrCodeURL = parcelDetails.qrCodeURL;
    copiedDetails.receivingTransporterId = parcelDetails.receivingTransporterId;
    copiedDetails.recievingTransporterName = parcelDetails.recievingTransporterName;
    copiedDetails.recievingTransporterAddress = parcelDetails.recievingTransporterAddress;
    copiedDetails.isReceived = parcelDetails.isReceived;
    copiedDetails.listParcelItems = parcelDetails.listParcelItems;
    copiedDetails.checked = parcelDetails.checked;
    copiedDetails.isSelected = parcelDetails.isSelected;

    copiedDetails.isScanned = parcelDetails.isScanned;
    copiedDetails.trackDescription = parcelDetails.trackDescription;
    copiedDetails.assignedDriverId = parcelDetails.assignedDriverId;
    copiedDetails._listPaymentDetails = parcelDetails.listPaymentDetails;

    return copiedDetails;
  }
}