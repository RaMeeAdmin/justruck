import 'package:justruck/beans/bean_date_time.dart';
import 'package:justruck/other/strings.dart';

class CommonFunctions
{
  static BeanDateTime getCurrentDateTime()
  {
    DateTime now = DateTime.now();

    BeanDateTime dateTimeBean = CommonFunctions.getFormattedDateTime(now);

    return dateTimeBean;
  }

  static BeanDateTime getFormattedDateTime(DateTime dateTime)
  {
    List<String> listMonth = Strings.listMonth;

    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    String twoDigitDay = day.toString();
    if(day<10) {
      twoDigitDay = "0"+day.toString();
    }

    String twoDigitMonth = month.toString();
    if(month<10)
    {
      twoDigitMonth = "0"+month.toString();
    }

    String strMonth = listMonth[month];

    String readableDate = twoDigitDay+"-"+strMonth+"-"+year.toString();

    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int seconds = dateTime.second;

    String hourStr = hour.toString();
    if(hour<10)
    {
      hourStr = "0"+hour.toString();
    }

    String minuteStr = minute.toString();
    if(minute<10)
    {
      minuteStr = "0"+minute.toString();
    }

    String date = year.toString()+"-"+twoDigitMonth+"-"+twoDigitDay;
    String time = hourStr+":"+minuteStr;

    String twelveHourTime = getTwelveHourTime(time);

    BeanDateTime dateTimeBean = new BeanDateTime(date, time);
    dateTimeBean.readableDate = readableDate;
    dateTimeBean.twelveHourTime = twelveHourTime;

    dateTimeBean.dateTime = dateTime;

    return dateTimeBean;
  }

  static String getTwelveHourTime(String hhMMSS)
  {
    if(hhMMSS.trim().isNotEmpty)
    {
      List<String> str = hhMMSS.split(":");
      int hour = int.parse(str[0]);
      int minute = int.parse(str[1]);

      String hourStr = hour.toString();
      if(hour<10) {
        hourStr = "0"+hour.toString();
      }

      String minuteStr = minute.toString();
      if(minute<10) {
        minuteStr = "0"+minute.toString();
      }

      String twelveHourTime = "";
      if(hour==12)
      {
        twelveHourTime = hourStr+":"+minuteStr+" PM";
      }
      else if(hour>12)
      {
        String newHour = (hour-12).toString();
        if((hour-12)<10) {
          newHour = "0"+(hour-12).toString();
        }
        twelveHourTime = newHour+":"+minuteStr+" PM";
      }
      else
      {
        twelveHourTime = hourStr+":"+minuteStr+" AM";
      }

      return twelveHourTime;
    }
    else
    {
      return "";
    }
  }

  static String getFormattedDate(String yyyyMMDD)
  {
    if(yyyyMMDD.trim().isNotEmpty) {
      DateTime dt = CommonFunctions.getDateTimeFromString(yyyyMMDD);
      BeanDateTime dtBean = CommonFunctions.getFormattedDateTime(dt);
      String formattedDate = dtBean.readableDate;
      return formattedDate;
    }
    else {
      return "";
    }
  }

  static DateTime getDateTimeFromString(String yyyymmdd)
  {
    List<String> str = yyyymmdd.split("-");
    int year = int.parse(str[0]);
    int month = int.parse(str[1]);
    int day = int.parse(str[2]);

    DateTime dateTime = new DateTime(year, month, day, 0, 0);
    return dateTime;
  }

  static String replacePatternByText(String pattern, String replacement, String text)
  {
    String replacedText = text;

    replacedText = text.replaceAll(pattern, replacement);

    return replacedText;
  }

  static bool compareStringsIgnoreCase(String s1, String s2)
  {
    if(s1.toLowerCase() == s2.toLowerCase()) {
      return true;
    }
    else {
      return false;
    }
  }

  static String getLanguageNameFromLocale(String locale)
  {
    String _languageName = "";

    if(locale.toString().toLowerCase()=="en")
    {
      _languageName = Strings.english;
    }
    else if(locale.toString().toLowerCase()=="mr")
    {
      _languageName = Strings.marathi;
    }

    return _languageName;
  }
}