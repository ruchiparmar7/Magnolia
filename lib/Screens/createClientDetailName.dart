import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Custom/Color.dart';

class CreateClientDetailName extends StatelessWidget {
  static String route = "CreateClientDetailName";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            tff(hintText: 'First Name', labelText: 'First Name'),
            SizedBox(height: 20),
            tff(hintText: 'Middle Name', labelText: 'Middle Name'),
            SizedBox(height: 20),
            tff(hintText: 'Last Name', labelText: 'Last Name'),
            SizedBox(height: 20),
            tff(hintText: 'Suffix', labelText: 'Suffix'),
            SizedBox(height: 20),
            tff(hintText: 'Preffered Name', labelText: 'Preffered Name'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  TextFormField tff({String? labelText, String? hintText}) {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(width: 1, color: Colors.blue),
        ),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
