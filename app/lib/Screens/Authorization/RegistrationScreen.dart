import 'package:epox_flutter/Shared/BottomPopups.dart';
import 'package:epox_flutter/Shared/Decorations.dart';
import 'package:flutter/material.dart';

import 'package:epox_flutter/Services/Authentication/AuthProvider.dart';
import 'package:epox_flutter/Services/Localization/AppLocalizations.dart';
import 'package:epox_flutter/Shared/Colors.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  final double height;
  final double width;
  final String title;
  final String buttonText;
  final String registerURL;
  final Function backFunction;
  final bool newAccount;
  final AppLocalizations locale;
  RegistrationScreen(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.title,
      @required this.buttonText,
      @required this.backFunction,
      @required this.registerURL,
      this.newAccount,
      @required this.locale})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  bool _passwordEmpty = true, _passwordVisible = false;
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final AuthProvider _auth = AuthProvider();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BottomPopup _bottomPopup = BottomPopup(context: context);

    return Container(
      height: widget.height,
      width: widget.width,
      padding: EdgeInsets.only(bottom: 30, left: 30, right: 30),
      decoration: BoxDecoration(
          color: DarkGrey,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: Blue, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Orange,
                    style: TextStyle(
                      fontSize: 20,
                      color: OffWhite,
                    ),
                    decoration: textInputDecoration.copyWith(
                      labelText: widget.locale.translate('emailPlaceholder'),
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Blue,
                      ),
                    ),
                    validator: (value) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) return null;
                      _bottomPopup
                          .showErrorFlushBar("Enter a Valid Email Address");
                      return "";
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    cursorColor: Orange,
                    style: TextStyle(
                      fontSize: 20,
                      color: OffWhite,
                    ),
                    decoration: textInputDecoration.copyWith(
                      labelText: widget.locale.translate('passwordPlaceholder'),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Blue,
                      ),
                      suffixIcon: _passwordEmpty
                          ? null
                          : IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: LightGrey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        value.length > 0
                            ? _passwordEmpty = false
                            : _passwordEmpty = true;
                      });
                    },
                    validator: widget.newAccount
                        ? (value) {
                            Pattern pattern =
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            if (RegExp(pattern).hasMatch(value)) {
                              return null;
                            }
                            _bottomPopup.showErrorFlushBar(
                                "Make sure your password contains at least one upper case letter, lower case letter, digit and a special character!");
                            return "";
                          }
                        : null,
                  ),
                  widget.newAccount
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            controller: _nameController,
                            cursorColor: Orange,
                            style: TextStyle(
                              fontSize: 20,
                              color: OffWhite,
                            ),
                            decoration: textInputDecoration.copyWith(
                              labelText:
                                  widget.locale.translate('namePlaceholder'),
                              prefixIcon: Icon(
                                Icons.person_pin,
                                color: Blue,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  widget.newAccount
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            controller: _usernameController,
                            cursorColor: Orange,
                            style: TextStyle(
                              fontSize: 20,
                              color: OffWhite,
                            ),
                            decoration: textInputDecoration.copyWith(
                              labelText: widget.locale
                                  .translate('usernamePlaceholder'),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Blue,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  splashColor: OffWhite,
                  borderRadius: BorderRadius.circular(15),
                  onTap: _loading
                      ? null
                      : () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });

                            dynamic result = widget.newAccount
                                ? await _signUp()
                                : await _login();

                            if (result.runtimeType == PlatformException) {
                              _bottomPopup
                                  .showErrorFlushBar(result.message.toString());

                              setState(() {
                                _loading = false;
                              });
                            }
                          }
                        },
                  child: Ink(
                    height: 55,
                    width: widget.width,
                    decoration: BoxDecoration(
                        color: Orange, borderRadius: BorderRadius.circular(15)),
                    child: _loading
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Blue),
                          ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.buttonText,
                                style: TextStyle(color: OffWhite, fontSize: 18),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                color: OffWhite,
                              )
                            ],
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  splashColor: Orange,
                  borderRadius: BorderRadius.circular(15),
                  onTap: widget.backFunction,
                  child: Ink(
                    height: 55,
                    width: widget.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Orange, width: 2.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Orange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.locale.translate('backButton'),
                          // "Go Back",
                          style: TextStyle(color: Orange, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _login() async {
    dynamic result = await _auth.emailSignIn(
      _emailController.text,
      _passwordController.text,
    );
    return result;
  }

  Future _signUp() async {
    dynamic result = await _auth.emailRegistration(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
        _usernameController.text);
    return result;
  }
}
