import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/home/bottom_navigation_screen.dart';
import 'package:justruck/login/login_screen.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'language/LanguageChangeProvider.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
          builder: (context) =>
              MaterialApp(
                locale: Provider.of<LanguageChangeProvider>(context, listen: true).currentLocale,
                //debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                title: Strings.jusTruck,
                theme: ThemeData(
                  primarySwatch: primaryColor,
                ),
                home: const MyHomePage(title: Strings.jusTruck),
              )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  late BuildContext mContext;

  @override
  void initState()
  {
    _jumpToNextScreen();
  }

  @override
  Widget build(BuildContext context)
  {
    mContext = context;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 9,
                child: CommonWidgets.getAppLogo(180,180),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(padding: const EdgeInsets.all(0.0),
                      child: Text(Strings.version+" "+_getAppVersion()),
                    ),
                  )
              )
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  String _getAppVersion()
  {
    if(Platform.isAndroid) {
      return CommonConstants.androidAppVersion;
    }
    else if(Platform.isIOS) {
      return CommonConstants.iOSAppVersion;
    }
    else {
      return "";
    }
  }

  void _jumpToNextScreen() async
  {
    bool isLoggedIn = await PreferenceHelper.getIsLoggedIn();

    _setLocale();

    Timer(Duration(seconds: 1), ()
    {
      if(isLoggedIn) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavigationScreen()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      }
    });
  }

  _setLocale() async
  {
    String locale = await PreferenceHelper.getAppLanguage();
    mContext.read<LanguageChangeProvider>().changeLocale(locale);
  }
}