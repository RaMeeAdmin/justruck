class BeanDateTime
{
  String _date = "", _time = "";
  String _readableDate = "";
  String _twelveHourTime = "";
  DateTime _dateTime = DateTime.now();


  BeanDateTime(this._date, this._time);

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  get time => _time;

  String get twelveHourTime => _twelveHourTime;

  set twelveHourTime(String value) {
    _twelveHourTime = value;
  }

  String get readableDate => _readableDate;

  set readableDate(String value) {
    _readableDate = value;
  }

  set time(value) {
    _time = value;
  }

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
  }

  static BeanDateTime getBlankDate()
  {
    BeanDateTime bdt = BeanDateTime("", "");
    bdt.readableDate = "";
    bdt._twelveHourTime = "";

    return bdt;
  }
}