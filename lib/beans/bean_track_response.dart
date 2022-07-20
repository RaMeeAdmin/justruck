import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_track_details.dart';

class BeanTrackResponse
{
  bool _success = false;
  String _message = "";

  BeanParcelDetails _parcelDetails = BeanParcelDetails.empty();
  List<BeanTrackDetails> _listTrackDetails = List.empty(growable: true);


  BeanTrackResponse(this._success, this._message);

  bool get success => _success;

  set success(bool value) {
    _success = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  BeanParcelDetails get parcelDetails => _parcelDetails;

  set parcelDetails(BeanParcelDetails value) {
    _parcelDetails = value;
  }

  List<BeanTrackDetails> get listTrackDetails => _listTrackDetails;

  set listTrackDetails(List<BeanTrackDetails> value) {
    _listTrackDetails = value;
  }
}