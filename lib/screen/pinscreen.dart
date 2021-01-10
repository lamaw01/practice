import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  StreamController<ErrorAnimationType> errorController;
  final String correctPass = '6669';
  var onTapRecognizer;

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  showAlertDialog() {
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter Pin',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: true,
                animationType: AnimationType.scale,
                errorAnimationController: errorController,
                animationDuration: Duration(milliseconds: 300),
                keyboardType: TextInputType.number,
                obscuringCharacter: '*',
                onChanged: (value) {
                  print(value);
                },
                pinTheme: PinTheme(
                  activeColor: Colors.blue,
                  selectedColor: Colors.red,
                  inactiveColor: Colors.orange,
                ),
                onCompleted: (value) {
                  if (value != correctPass) {
                    print('Error');
                    errorController.add(ErrorAnimationType.shake);
                  } else {
                    print('Success');
                    showAlertDialog();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
