import 'package:flutter/material.dart';
import 'package:practice/services/multisysApi.dart';

class VoidTransaction extends StatefulWidget {
  @override
  _VoidTransactionState createState() => _VoidTransactionState();
}

class _VoidTransactionState extends State<VoidTransaction> {
  final TextEditingController refnoController = TextEditingController();
  var voidResult;
  var scaffoldValueToPass = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  voidTransaction(String refno) async {
    voidResult = await MultisysApi().postvoidTransaction(refno);
    setState(() {
      scaffoldValueToPass = voidResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Void Transaction'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Refno'),
              TextField(
                controller: refnoController,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
                child: Text('Void Transaction'),
                onPressed: () async {
                  String refno = refnoController.text;

                  if (refno.isNotEmpty) {
                    await voidTransaction(refno);
                  } else {
                    setState(() {
                      scaffoldValueToPass = 'Null';
                    });
                  }

                  // ignore: deprecated_member_use
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 6),
                      content: Text(
                        scaffoldValueToPass,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
