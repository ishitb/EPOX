import 'package:epox_flutter/Screens/Authorization/RegistrationScreen.dart';
import 'package:epox_flutter/Shared/Colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool _checkSignUp = false, _checkLogin = false;
  @override
  Widget build(BuildContext context) {
    bool _keyboardUp = MediaQuery.of(context).viewInsets.bottom != 0;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        setState(() {
          _checkLogin = false;
          _checkSignUp = false;
        });
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Hello",
                      style: TextStyle(color: OffWhite, fontSize: 30),
                      children: [
                        TextSpan(text: '!\n', style: TextStyle(color: Orange)),
                        TextSpan(
                            text:
                                "Let's get started with solving Road Management issues with ",
                            style: TextStyle(fontSize: 24)),
                        TextSpan(
                            text: "EPOX",
                            style: TextStyle(color: Orange, fontSize: 24))
                      ],
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Login to Account",
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
                          "Create New Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: OffWhite, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
                  buttonText: "Login",
                  registerURL: "",
                  title: "Login to Continue",
                  newAccount: false,
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
                  buttonText: "Sign Up",
                  registerURL: "",
                  title: "Create New Account",
                  newAccount: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
