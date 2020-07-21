import 'package:flutter/material.dart';
import 'package:epox_flutter/Shared/Colors.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:epox_flutter/Screens/Authorization/RegistrationScreen.dart';
import 'package:epox_flutter/Services/Localization/AppLocalizations.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  AppLocalizations _locale;
  bool _checkSignUp = false, _checkLogin = false;
  @override
  Widget build(BuildContext context) {
    _locale = AppLocalizations.of(context);
    bool _keyboardUp = MediaQuery.of(context).viewInsets.bottom != 0;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        setState(() {
          _checkLogin = false;
          _checkSignUp = false;
        });
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: DarkBlue,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: _checkLogin || _checkSignUp ? 0 : height / 10,
                    child: Image.network(
                        'https://www.sih.gov.in/img1/SMART-INDIA-HACKATHON-2020.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        // text: "Hello",
                        text: _locale.translate('heading1'),
                        style: TextStyle(color: OffWhite, fontSize: 30),
                        children: [
                          TextSpan(
                              text: '!\n', style: TextStyle(color: Orange)),
                          TextSpan(
                              text: _locale.translate('heading2'),
                              // "Let's get started with solving Road Management issues with ",
                              style: TextStyle(fontSize: 24)),
                          TextSpan(
                              text: "  EPOX",
                              style: TextStyle(color: Orange, fontSize: 24))
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: _checkLogin || _checkSignUp ? height / 10 : 0,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: height / 3.5,
                        child: FlareActor(
                          'assets/flare/onboarding.flr',
                          animation: 'OnBoarding',
                        ),
                        // Image.asset('assets/images/onboarding.png'),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: InkWell(
                      splashColor: Orange,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          _checkLogin = true;
                        });
                      },
                      child: Ink(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Orange),
                          borderRadius: BorderRadius.circular(20),
                          color: DarkBlue,
                        ),
                        child: Text(
                          _locale.translate('loginHead'),
                          // "Login to Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: OffWhite, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: InkWell(
                      splashColor: Orange,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          _checkSignUp = true;
                        });
                      },
                      child: Ink(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Orange),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          _locale.translate('signUpHead'),
                          // "Create New Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: OffWhite, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _checkLogin = false;
                      _checkSignUp = false;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: height * 0.25,
                  )),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.translationValues(
                    0,
                    _checkLogin ? (_keyboardUp ? 0 : height * 0.25) : height,
                    1),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
                child: RegistrationScreen(
                  height: height * 0.75,
                  width: width,
                  backFunction: () {
                    setState(() {
                      _checkLogin = false;
                    });
                  },
                  buttonText: _locale.translate('loginButton'),
                  // "Login",
                  registerURL: "",
                  title: _locale.translate('loginHead'),
                  // "Login to Continue",
                  newAccount: false,
                  locale: _locale,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.translationValues(
                    0,
                    _checkSignUp ? (_keyboardUp ? 0 : height * 0.25) : height,
                    1),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
                child: RegistrationScreen(
                  height: height * 0.75,
                  width: width,
                  backFunction: () {
                    setState(() {
                      _checkSignUp = false;
                    });
                  },
                  buttonText: _locale.translate('signUpButton'),
                  // "Sign Up",
                  registerURL: "",
                  title: _locale.translate('signUpHead'),
                  // "Create New Account",
                  newAccount: true,
                  locale: _locale,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 15.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    splashColor: Blue,
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      setState(() {
                        _locale = _locale.changeLanguage();
                      });
                    },
                    child: Ink(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: OffWhite,
                            width: 2,
                          )),
                      // ignore: missing_required_param
                      child: Icon(
                        Icons.translate,
                        color: OffWhite,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
