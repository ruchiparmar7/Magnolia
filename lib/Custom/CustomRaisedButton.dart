import 'package:flutter/material.dart' hide Badge;

class CustomRaisedButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonBg;
  final Color? buttonTextColor;
  final VoidCallback? click;

  CustomRaisedButton(
      {this.buttonText, this.buttonBg, this.buttonTextColor, this.click});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            backgroundColor: buttonBg),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            buttonText!,
            style: TextStyle(color: buttonTextColor, fontSize: 17),
          ),
        ),
        //color: buttonBg,
        onPressed: () {
          click!();
        });
  }
}
