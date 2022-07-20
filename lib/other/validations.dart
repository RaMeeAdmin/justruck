class Validations
{
  static bool isValidPanNo(String panNo)
  {
    bool valid = false;

    panNo = panNo.toUpperCase();

    if(panNo.length!=10)
    {
      valid = false;
    }
    else
    {
      bool isMatched = RegExp('[A-Z]{5}[0-9]{4}[A-Z]{1}').hasMatch(panNo);
      if(isMatched) {
        valid = true;
      }
      else {
        valid = false;
      }
    }

    return valid;
  }

  static bool isValidGstNo(String gstNo)
  {
    bool valid = false;

    gstNo = gstNo.toUpperCase();

    if(gstNo.length!=15)
    {
      valid = false;
    }
    else
    {
      bool isMatched = RegExp('[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}').hasMatch(gstNo);
      if(isMatched) {
        valid = true;
      }
      else {
        valid = false;
      }
    }

    return valid;
  }

  static bool isValidEmailId(String value)
  {
    RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return (regex.hasMatch(value)) ? true : false;
  }
}