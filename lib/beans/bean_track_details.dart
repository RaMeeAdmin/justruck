import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/other/common_constants.dart';

class BeanTrackDetails
{
  String _id = "", _parcelId = "";
  String _date = "", _time = "", _status = "";
  String _description = "";
  String _address = "";

  BeanTrackDetails(this._id, this._parcelId, this._date, this._time, this._status, this._description);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get parcelId => _parcelId;

  set parcelId(value) {
    _parcelId = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  get time => _time;

  set time(value) {
    _time = value;
  }

  get status => _status;

  set status(value) {
    _status = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }


  String get address => _address;

  set address(String value) {
    _address = value;
  }

  static List<BeanTrackDetails> getDefaultTrackingDetails()
  {
    List<BeanTrackDetails> _listTrackDetails = List.empty(growable: true);

    _listTrackDetails.add(BeanTrackDetails("1", "P-12345", "2022-01-24", "18:45:12", CommonConstants.statusBooked, "Parcel Booked at Fursungi Pune"));
    _listTrackDetails.add(BeanTrackDetails("2", "P-12345", "2022-01-24", "18:52:12", CommonConstants.statusBooked, "Parcel Packed at Fursungi Pune"));
    _listTrackDetails.add(BeanTrackDetails("3", "P-12345", "2022-01-25", "07:08:31", CommonConstants.statusBooked, "Manifest Generated and Vehicle Assigned"));
    _listTrackDetails.add(BeanTrackDetails("4", "P-12345", "2022-01-25", "09:12:24", CommonConstants.statusInTransit, "Parcel made In - Transit"));
    _listTrackDetails.add(BeanTrackDetails("5", "P-12345", "2022-01-25", "14:04:09", CommonConstants.statusInTransit, "Parcel Scanned at Shirur"));
    _listTrackDetails.add(BeanTrackDetails("6", "P-12345", "2022-01-25", "16:32:12", CommonConstants.statusInTransit, "Parcel Reached At Ahmednagar Office"));
    _listTrackDetails.add(BeanTrackDetails("7", "P-12345", "2022-01-25", "17:30:30", CommonConstants.statusDelivered, "Delivered to Customer"));

    return _listTrackDetails;
  }
}