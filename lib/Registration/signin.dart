import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:magnolia/Constant/constants.dart';
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/Custom/CustomRaisedButton.dart';
import 'package:magnolia/Custom/CustomTextField.dart';
import 'package:magnolia/Custom/CustomTextFieldSignUp.dart';
import 'package:magnolia/Registration/signup.dart';
import 'package:magnolia/NavigationDrawer/bottomNavigation.dart';
import 'package:http/http.dart' as http;
import 'package:magnolia/api.dart';

// TODO: Validation remaining.
class SignIn extends StatefulWidget {
  static String route = "SignIn";
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _autoValidate = false;
  String sText1 = "Welcome To";
  String signInButtonText = "Sign In";
  String password = "Password";
  String phoneNumber = "Enter Your Email";
  var _signInFormKey = GlobalKey<FormState>();
  String? _email1;
  String? _password1;

  String result = 'Status: Sign In now !';
  bool isLoading = false;
  bool submitButtonEnable = true;

  Future<void> _submit() async {
    if (_signInFormKey.currentState!.validate()) {
      //    If all data are correct then save data to out variables
      _signInFormKey.currentState!.save();
      setState(() {
        submitButtonEnable = false;
        isLoading = true;
      });

      final Uri postUri = signInApi;

      Map mapeddate = {
        'doc_email': _email1,
        'doc_password': _password1,
      };
      //send  data using http post to our php code

      try {
        /* Comment login logic for now
        http.Response reponse = await http.post(postUri, body: mapeddate);
        var datae = jsonDecode(reponse.body);*/
        setState(() {
          isLoading = false;
          result = "Status: Success";
          submitButtonEnable = true;
        });

        Future.delayed(const Duration(milliseconds: 1500), () {
          // Here you can write your code
          //if (datae['success'] == 1) {
          Navigator.of(context).pushNamed(CustomBottomNavigationBar.route);
          // }
        });
      } on SocketException {
        setState(() {
          isLoading = false;
          submitButtonEnable = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Connect to the Internet"),
          duration: Duration(seconds: 6),
        ));
      } catch (e) {
        setState(() {
          isLoading = false;
          result = "Status: Failed to Sign In";
          submitButtonEnable = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to Sign In"),
          duration: Duration(seconds: 6),
        ));
      }
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [Green, Green, Black],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Text(sText1,
                        style: TextStyle(
                          fontSize: 22,
                          color: White,
                        )),
                    //SizedBox(height: 10,),
                    Image.asset(
                      logo,
                      //height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Center(
                      child: Image.asset(
                        bgLogo,
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width * .9,
                      ),
                    ),

                    SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: _signInFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          //text color
                          CustomTextFieldSignUp(
                            textcolor: Colors.white,
                            fieldText: phoneNumber,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a valid email!';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _email1 = newValue;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          // CustomTextFieldData(
                          //   fieldText: phoneNumber,
                          //   obscureText: false,
                          //   validator: (value) {
                          //     if (value.isEmpty ||
                          //         !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          //             .hasMatch(value)) {
                          //       return 'Enter a valid email!';
                          //     }
                          //     return null;
                          //   },
                          //   onSaved: (newValue) {
                          //     _email1 = newValue;
                          //   },
                          // ),
                          CustomTextFieldData(
                            fieldText: password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a password';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _password1 = newValue;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 150,
                            child: CustomRaisedButton(
                              click: () =>
                                  submitButtonEnable ? _submit() : null,
                              buttonText: signInButtonText,
                              buttonTextColor: Green,
                              buttonBg: White,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(SignUp.route);
                      },
                      child: Text(
                        "Create Account?",
                        style: TextStyle(color: White, fontSize: 16),
                      ),
                    ),

                    SizedBox(height: 15),
                    Text(
                      result,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              child: Center(
                child: SpinKitFadingCube(color: Colors.white),
              ),
              visible: isLoading,
            )
          ],
        ),
      ),
    );
  }
}
