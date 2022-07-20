import 'package:flutter/material.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYouScreen extends StatefulWidget
{
  _ThankYouScreen createState() => _ThankYouScreen();
}

class _ThankYouScreen extends State<ThankYouScreen>
{
  @override
  void initState()
  {

  }

  Future<bool> _onWillPop()
  {
    Navigator.of(context).pop();
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Image.asset('assets/backgrounds/loginBg.png', fit: BoxFit.cover)
                )
              ],
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).thankYou.toUpperCase(),
                        style: GoogleFonts.permanentMarker(fontSize: 40, letterSpacing: 2.0, color: logo3)
                    ),
                    Text( S.of(context).thankYouMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle( fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:20),
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(S.of(context).backToLogin, style: Style.skyBlueText(size: 20, letterSpacing: 0.0, textColor: skyBlue))
                            ],
                          ),
                        ),
                        onTap: () =>
                        {
                          Navigator.of(context).pop(),
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}