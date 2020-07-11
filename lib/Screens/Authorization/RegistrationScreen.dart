import 'package:epox_flutter/Shared/Colors.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final double height;
  final double width;
  final String title;
  final String buttonText;
  final String registerURL;
  final Function backFunction;
  final bool newAccount;
  RegistrationScreen(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.title,
      @required this.buttonText,
      @required this.backFunction,
      @required this.registerURL,
      this.newAccount})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  bool _passwordEmpty = false, _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _password2Controller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Orange,
                  style: TextStyle(
                    fontSize: 20,
                    color: OffWhite,
                  ),
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline, color: Blue),
                      labelText: "Email Address",
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Blue)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  cursorColor: Orange,
                  style: TextStyle(
                    fontSize: 20,
                    color: OffWhite,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Blue,
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Blue),
                    border: InputBorder.none,
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
                ),
              ),
              widget.newAccount
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _password2Controller,
                        obscureText: true,
                        cursorColor: Orange,
                        style: TextStyle(
                          fontSize: 20,
                          color: OffWhite,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Blue,
                            ),
                            labelText: "Confirm Password",
                            border: InputBorder.none,
                            labelStyle: TextStyle(color: Blue)),
                      ),
                    )
                  : Container()
            ],
          ),
          Column(
            children: [
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  splashColor: OffWhite,
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    String url = widget.registerURL;
                  },
                  child: Ink(
                    height: 55,
                    width: widget.width,
                    decoration: BoxDecoration(
                        color: Orange, borderRadius: BorderRadius.circular(15)),
                    child: Row(
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
                          "Go Back",
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
}
