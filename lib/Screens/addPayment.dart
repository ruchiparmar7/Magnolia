import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Custom/Color.dart';

//TODO: Validation paybalance > balance thrn popup

class AddPayment extends StatefulWidget {
  static String route = "AddPayment";

  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  String _selectedValue = "Cash";
  int _groupValue = 1;
  double balance = 10000;
  double payBalance = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("Add Payment"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Payment Amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Balance",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Remaining amount from Client",
                            style: TextStyle(fontSize: 8.0, color: Colors.red),
                          )
                        ],
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "\$" + balance.toString(),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Other",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Amount Recieved from Client",
                        style: TextStyle(fontSize: 8.0, color: Colors.red),
                      )
                    ],
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          payBalance = double.parse(value);
                        });
                      }
                    },
                    keyboardType: TextInputType.number,
                    readOnly: false,
                    initialValue: payBalance.toString(),
                    decoration: InputDecoration(),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MyDialog(
                        onValueChange: _onValueChange,
                        initialValue: _groupValue,
                      );
                    });
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(_selectedValue)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  balance = balance - payBalance;
                });
              },
              child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        "Payment",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _onValueChange(int groupValue, String selectedValue) {
    setState(() {
      _groupValue = groupValue;
      _selectedValue = selectedValue;
    });
  }

  void calculate() {}
}

class MyDialog extends StatefulWidget {
  const MyDialog({
    this.onValueChange,
    this.initialValue,
  });

  final int? initialValue;
  final void Function(int, String)? onValueChange;

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  int? _groupValue;
  void Function(int, String)? _onValueChange;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.initialValue;
    _onValueChange = widget.onValueChange;
  }

  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: new Text("Payment Method"),
      children: <Widget>[
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: _myRadioButton(
                title: "Cash",
                value: 1,
                onChanged: (newValue) => setState(() {
                  _groupValue = newValue;
                  _onValueChange!(1, "Cash");
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: _myRadioButton(
                title: "Credit Card",
                value: 2,
                onChanged: (newValue) => setState(() {
                  _groupValue = newValue;
                  _onValueChange!(2, "Credit Card");
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: _myRadioButton(
                title: "Check",
                value: 3,
                onChanged: (newValue) => setState(() {
                  _groupValue = newValue;
                  _onValueChange!(3, "Check");
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _myRadioButton(
      {String? title, int? value, void Function(int?)? onChanged}) {
    return RadioListTile<int>(
      activeColor: Green,
      value: value!,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title!),
      selected: false,
    );
  }
}
