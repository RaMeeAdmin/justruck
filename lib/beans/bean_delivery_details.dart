import 'dart:typed_data';

class BeanDeliveryDetails
{
  String _parcelId = "";
  String _podImage = "", _signatureImage = "", _receiverImage = "";
  String _receiverName  = "", _receiverMobileNo = "";

  String _latitude = "", _longitude = "", _address = "";
  String _trackStatus = "";

  BeanDeliveryDetails(this._parcelId, this._receiverName);

  String get receiverName => _receiverName;

  set receiverName(String value) {
    _receiverName = value;
  }

  get receiverImage => _receiverImage;

  set receiverImage(value) {
    _receiverImage = value;
  }

  get signatureImage => _signatureImage;

  set signatureImage(value) {
    _signatureImage = value;
  }

  String get podImage => _podImage;

  set podImage(String value) {
    _podImage = value;
  }

  String get parcelId => _parcelId;

  set parcelId(String value) {
    _parcelId = value;
  }

  get address => _address;

  set address(value) {
    _address = value;
  }

  get longitude => _longitude;

  set longitude(value) {
    _longitude = value;
  }

  String get latitude => _latitude;

  set latitude(String value) {
    _latitude = value;
  }

  String get trackStatus => _trackStatus;

  set trackStatus(String value) {
    _trackStatus = value;
  }

  get receiverMobileNo => _receiverMobileNo;

  set receiverMobileNo(value) {
    _receiverMobileNo = value;
  }
}