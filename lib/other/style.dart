
import 'package:flutter/material.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/fonts.dart';

class Style
{
  static double dashboardTextSize = 35;
  static double dashboardIconSize = 32;
  static double drawerIconSize = 18;

  static TextStyle boldTextStyle(
      {
        int size = 18,
        Color textColor = skyBlue,
        FontWeight textWeight = FontWeight.bold,
        double letterSpacing = 1.0,
        double wordSpacing = 1.0
      })
  {
    return TextStyle(
        fontSize: size.toDouble(),
        color: textColor,
        fontWeight: textWeight,
        letterSpacing: letterSpacing,
        fontFamily: fontBold,
        wordSpacing: wordSpacing
    );
  }

  static TextStyle skyBlueText(
      {
        int size = 18,
        Color textColor = skyBlue,
        double letterSpacing = 1.0,
        double wordSpacing = 1.0,
      })
  {
    return TextStyle(
        fontSize: size.toDouble(),
        color: textColor,
        letterSpacing: letterSpacing,
        fontFamily: fontBold,
        wordSpacing: wordSpacing
    );
  }

  static ButtonStyle getButtonBackground()
  {
    return ElevatedButton.styleFrom(primary: skyBlue);
  }

  static BoxDecoration getRoundedGreyBorder()
  {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(
        color: Colors.grey,
        width: 1.0,
      ),
    );
  }

  static EdgeInsetsGeometry getTextFieldContentPadding()
  {
    return const EdgeInsets.only(left: 10);
  }

  static Color getColorByParcelStatus(String status)
  {
    Color color = darkYellow;
    if(status.toLowerCase()==CommonConstants.statusBooked.toLowerCase())
    {
      color = darkOrange;
    }
    else if(status.toLowerCase()==CommonConstants.statusInTransit.toLowerCase())
    {
      color = darkYellow;
    }
    else if(status.toLowerCase()==CommonConstants.statusScanned.toLowerCase())
    {
      color = logo2;
    }
    else if(status.toLowerCase()==CommonConstants.statusReceived.toLowerCase())
    {
      color = purple;
    }
    else if(status.toLowerCase()==CommonConstants.statusDelivered.toLowerCase())
    {
      color = darkGreen;
    }

    return color;
  }

  static TextStyle dashboardTextStyle({int size = 18, fontFamily: "Poppins",}) {
    return TextStyle(fontSize: size.toDouble(), fontFamily: fontFamily);
  }

  static BoxDecoration getIconButtonStyle()
  {
    return const BoxDecoration(
      color: skyBlue,
      borderRadius: BorderRadius.all(
        Radius.circular(3.0),
      ),
    );
  }

  static BoxDecoration getSquareBorder()
  {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(0.0),
      border: Border.all(
        color: Colors.black,
        width: 0.5,
      ),
    );
  }

  static BoxDecoration getSquareBorderWithFill(
  {
    Color fillColor = veryLightGray,
  })
  {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(0.0),
      color: fillColor,
      border: Border.all(
        color: Colors.black,
        width: 0.5,
      ),
    );
  }
}