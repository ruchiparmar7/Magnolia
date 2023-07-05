import 'package:flutter/material.dart' hide Badge;

import 'Color.dart';

class CustomTextFieldData extends StatefulWidget {
  final String? fieldText;

  final bool? enabled;
  final bool? keyboardtype;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  CustomTextFieldData(
      {this.fieldText,
      this.enabled,
      this.keyboardtype,
      this.validator,
      this.onSaved});

  @override
  _CustomTextFieldDataState createState() => _CustomTextFieldDataState();
}

class _CustomTextFieldDataState extends State<CustomTextFieldData> {
  bool? passwordVisible;

  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
      child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextFormField(
                      obscureText:
                          !passwordVisible!, //This will obscure text dynamically
                      validator: widget.validator,
                      onSaved: widget.onSaved,
                      style: TextStyle(fontSize: 16, color: White),
                      decoration: InputDecoration(
                        hintText: widget.fieldText,
                        hintStyle: TextStyle(fontSize: 16, color: Grey),
                        border: new UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Grey, width: 1.3)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Grey, width: 1.3),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Green, width: 1.3),
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible!
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible!;
                            });
                          },
                        ),

                        //border: InputBorder.none,
                        //focusedBorder: InputBorder.none,
                        //enabledBorder: InputBorder.none,

                        //disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 0, bottom: 0, top: 14, right: 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
