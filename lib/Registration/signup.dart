import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/Custom/CustomRaisedButton.dart';
import 'package:magnolia/Custom/CustomTextFieldSignUp.dart';
import 'package:magnolia/api.dart';

// TODO: IOS internet permission
class SignUp extends StatefulWidget {
  static String route = "SignUp";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String sHeading = "Hello";
  String sSubHeading = "Create an account to continue";
  String sBottomTextLeft = "Already have an account?";
  String sBottomTextRight = "SIGN IN";
  String sSignUpButtonText = "Sign Up";
  bool _autoValidate = false;
  var _signUpFormKey = GlobalKey<FormState>();
  String? _fullName;
  String? _email;
  String? _password;
  String? _phoneNumber;
  String result = 'Status: Sign Up now !';
  bool isLoading = false;
  bool submitButtonEnable = true;
  FocusNode? fName;
  FocusNode? fEmail;
  FocusNode? fPass;
  FocusNode? fPhoneNumber;

  void initState() {
    super.initState();
    fName = FocusNode();
    fEmail = FocusNode();
    fPass = FocusNode();
    fPhoneNumber = FocusNode();
  }

  void dispose() {
    super.dispose();
    fName!.dispose();
    fEmail!.dispose();
    fPass!.dispose();
    fPhoneNumber!.dispose();
  }

  Future<void> _submit() async {
    if (_signUpFormKey.currentState!.validate()) {
//    If all data are correct then save data to out variables
      _signUpFormKey.currentState!.save();
      setState(() {
        submitButtonEnable = false;
        isLoading = true;
      });
      print(_fullName! + _email! + _password! + _phoneNumber!);

      final Uri postUri = signUpApi;

      Map mapeddate = {
        'doc_fullname': _fullName,
        'doc_email': _email,
        'doc_phone': _phoneNumber,
        'doc_password': _password,
      };
      //send  data using http post to our php code

      try {
        http.Response reponse = await http.post(postUri, body: mapeddate);
        var datae = jsonDecode(reponse.body);
        setState(() {
          isLoading = false;
          result = "Status: ${datae['message']}";
          submitButtonEnable = true;
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
          result = "Status: Failed to Registration";
          submitButtonEnable = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to Registration"),
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
            SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _signUpFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        sHeading,
                        style: TextStyle(
                            color: Green,
                            fontSize: MediaQuery.of(context).size.height * .1),
                      ),
                      Text(
                        sSubHeading,
                        style: TextStyle(color: Green, fontSize: 17),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFieldSignUp(
                        textcolor: Colors.black,
                        autofocus: true,
                        fieldText: "FullName",
                        focusNode: fName,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid Full Name!';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _fullName = newValue;
                        },
                        onFieldSubmitted: (value) {
                          fName!.unfocus();
                          FocusScope.of(context).requestFocus(fEmail);
                        },
                      ),
                      CustomTextFieldSignUp(
                        textcolor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        fieldText: "Email",
                        focusNode: fEmail,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _email = newValue;
                        },
                        onFieldSubmitted: (value) {
                          fEmail!.unfocus();
                          FocusScope.of(context).requestFocus(fPass);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      CustomTextFieldSignUp(
                        textcolor: Colors.black,
                        obscureText: false,
                        focusNode: fPass,
                        textInputAction: TextInputAction.next,
                        fieldText: "Password",
                        validator: (value) {
                          //comment : For strong password
                          // if (value.isEmpty ||
                          //     !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                          //         .hasMatch(value)) {
                          //   return 'Enter min 8 character,at least 1 upper case,lower case,number & special character';

                          if (value!.isEmpty) {
                            return 'Enter a Password';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _password = newValue;
                        },
                        onFieldSubmitted: (value) {
                          fPass!.unfocus();
                          FocusScope.of(context).requestFocus(fPhoneNumber);
                        },
                      ),
                      CustomTextFieldSignUp(
                        textcolor: Colors.black,
                        focusNode: fPhoneNumber,
                        fieldText: "Phone Number",
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                            return 'Enter valid 10 digit number';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _phoneNumber = newValue;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        width: 150,
                        child: CustomRaisedButton(
                          click: () => submitButtonEnable ? _submit() : null,
                          buttonText: sSignUpButtonText,
                          buttonTextColor: White,
                          buttonBg: Green,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Row(
                          children: [
                            Text(
                              sBottomTextLeft,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              sBottomTextRight,
                              style: TextStyle(
                                color: Black,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(result)
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              child: Center(
                child: SpinKitFadingCube(
                  color: Green,
                ),
              ),
              visible: isLoading,
            )
          ],
        ),
      ),
    );
  }
}
