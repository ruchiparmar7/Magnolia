import 'package:flutter/material.dart' hide Badge;

import 'Color.dart';

class CustomTextFieldSignUp extends StatelessWidget {
  final String? fieldText;
  final bool? obscureText;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Color? textcolor;
  CustomTextFieldSignUp(
      {@required this.fieldText,
      this.obscureText,
      @required this.validator,
      @required this.onSaved,
      this.focusNode,
      this.onFieldSubmitted,
      this.autofocus,
      @required this.textInputAction,
      this.keyboardType,
      @required this.textcolor});

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
                  textInputAction: textInputAction,
                  focusNode: focusNode ?? null,
                  onFieldSubmitted: onFieldSubmitted ?? null,
                  obscureText: obscureText ?? false,
                  keyboardType: keyboardType ?? null,
                  validator: validator,
                  onSaved: onSaved,
                  autofocus: autofocus ?? false,
                  style: TextStyle(
                    fontSize: 16,
                    color: textcolor,
                  ),
                  decoration: InputDecoration(
                    hintText: fieldText,
                    hintStyle: TextStyle(fontSize: 16, color: Grey),
                    border: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Grey, width: 1.3)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Grey, width: 1.3),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Green, width: 1.3),
                    ),

                    //border: InputBorder.none,
                    //focusedBorder: InputBorder.none,
                    //enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    //disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 0, bottom: 0, top: 14, right: 0),
                  ),
                ))),
              ],
            ),
          )),
    );
  }
}
