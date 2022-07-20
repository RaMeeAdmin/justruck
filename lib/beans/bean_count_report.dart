class BeanCountReport
{
  String _fromDate = "", _toDate = "";
  String _totalParcelBooked = "", _totalPaidBookings = "", _totalToPayBookings = "";
  String _totalBookingAmount = "", _cardPaymentAmount = "", _cashPaymentAmount = "",
         _upiPaymentAmount = "", _creditPaymentAmount = "";
  String _totalParcelDelivered = "";


  BeanCountReport(this._fromDate, this._toDate);

  String get fromDate => _fromDate;

  set fromDate(String value) {
    _fromDate = value;
  }

  get toDate => _toDate;

  set toDate(value) {
    _toDate = value;
  }

  String get totalParcelBooked => _totalParcelBooked;

  set totalParcelBooked(String value) {
    _totalParcelBooked = value;
  }

  get totalPaidBookings => _totalPaidBookings;

  String get totalParcelDelivered => _totalParcelDelivered;

  set totalParcelDelivered(String value) {
    _totalParcelDelivered = value;
  }

  get creditPaymentAmount => _creditPaymentAmount;

  set creditPaymentAmount(value) {
    _creditPaymentAmount = value;
  }

  get upiPaymentAmount => _upiPaymentAmount;

  set upiPaymentAmount(value) {
    _upiPaymentAmount = value;
  }

  get cashPaymentAmount => _cashPaymentAmount;

  set cashPaymentAmount(value) {
    _cashPaymentAmount = value;
  }

  get cardPaymentAmount => _cardPaymentAmount;

  set cardPaymentAmount(value) {
    _cardPaymentAmount = value;
  }

  String get totalBookingAmount => _totalBookingAmount;

  set totalBookingAmount(String value) {
    _totalBookingAmount = value;
  }

  set totalPaidBookings(value) {
    _totalPaidBookings = value;
  }

  get totalToPayBookings => _totalToPayBookings;

  set totalToPayBookings(value) {
    _totalToPayBookings = value;
  }
}