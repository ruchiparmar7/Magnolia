import 'package:flutter/material.dart' hide Badge;

import 'Color.dart';

class MyCustomButton extends StatefulWidget {
  var textContent;
  final VoidCallback? onPressed;

  MyCustomButton({
    @required this.textContent,
    @required this.onPressed,
  });
  @override
  _MyCustomButtonState createState() => _MyCustomButtonState();
}

class _MyCustomButtonState extends State<MyCustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          textStyle: TextStyle(
            color: Color(0XFFFFFFFF),
          ),
          padding: const EdgeInsets.all(0.0),
        ),
        onPressed: widget.onPressed,
        //textColor: Color(0XFFFFFFFF),
        //elevation: 4,
        //shape:
        // RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),

        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[Color(0XFF212121), Green]),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
