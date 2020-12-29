import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:practice/screen/webpage.dart';
// import 'package:practice/screen/webpage.dart';
import 'package:practice/services/multisysApi.dart';

class Order extends StatefulWidget {
  Order({Key key, this.amountVal, this.menuName}) : super(key: key);

  final String amountVal;
  final String menuName;

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final TextEditingController amountController = TextEditingController();
  var _generatedRefno;
  var _apiUrl;

  // WALA PANIY GAMIT LAKBAYI LANG
  // CALL THE GENERATE REFERENCE
  // generateReference(amount, txnid, digest, callbackUrl) async {
  //   try {
  //     _generatedRefno = await MultisysApi()
  //         .postgenerateReference(amount, txnid, digest, callbackUrl);

  //     // CALLS THE INITIALIZED WITHIN THE GENERATE REF # WITH DELAY
  //     Future.delayed(Duration(seconds: 1), () {
  //       initializeTransaction(amount, txnid, digest, callbackUrl);
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  //DITSO NA DIRE PARA LOAD SA PAGE
  // INITIALIZE TRANSACTION
  initializeTransaction(amount, txnid, digest, callbackUrl) async {
    try {
      _apiUrl = await MultisysApi()
          .postinitializedTransaction(amount, txnid, digest, callbackUrl);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebPage(
            apiUrl: _apiUrl,
            refNo: _generatedRefno,
          ),
        ),
      );
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.arrow_forward),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => WebPage(
          //           apiUrl: _apiUrl,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 180,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              widget.menuName == null
                                  ? Text('')
                                  : Text(
                                      'Title: ' + widget.menuName,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                              widget.amountVal == null
                                  ? Text('')
                                  : Text(
                                      'Price: ' + widget.amountVal,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      child: Text('Place Order'),
                      onPressed: () {
                        // THE ARGUMENT NEEDED FOR THE API POST
                        final String amount = widget.amountVal;
                        var rng = new Random();
                        var txnid = rng.nextInt(9000) + 1000;
                        final String callbackUrl = MultisysApi.callbackUrl;
                        // print(callbackUrl);
                        final String multipayToken = MultisysApi.multipayToken;
                        final String toDigest =
                            (amount + txnid.toString() + multipayToken);
                        var bytes = utf8.encode(toDigest); // data being hashed
                        var digest = sha1.convert(bytes).toString();
                        // print(amount + txnid.toString() + callbackUrl + digest);

                        // CALL THE FUNCTION
                        initializeTransaction(
                            amount, txnid.toString(), digest, callbackUrl);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
