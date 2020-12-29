import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:practice/services/multisysApi.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebPage extends StatefulWidget {
  WebPage({Key key, this.apiUrl, this.refNo}) : super(key: key);

  final String apiUrl;
  final String refNo;

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final Completer<WebViewController> _webPageController =
      Completer<WebViewController>();
  bool loading = true;

  // VOID TRANSACTION FUNCTION
  voidTransaction(refNo) async {
    await MultisysApi().postvoidTransaction(refNo);
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiPay'),
        // leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       voidTransaction(widget.refNo);
        //       Navigator.pop(context, true);
        //     }),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              onWebResourceError: (WebResourceError webviewerrr) {
                print('Weberror description: ' + webviewerrr.description);
              },
              initialUrl: widget.apiUrl,
              onPageFinished: (initialUrl) {
                print('Page finished loading: $initialUrl');
                setState(() {
                  loading = false;
                });
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('http://redirect-url/')) {
                  print('blocking navigation to $request}');
                  Navigator.pop(context);
                  // _launchURL('https://my.redirect.url.com');
                  return NavigationDecision.prevent;
                }

                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                _webPageController.complete(controller);
              },
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center()
          ],
        ),
      ),
    );
  }
}
