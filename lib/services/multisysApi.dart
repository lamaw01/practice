import 'package:http/http.dart' as http;
import 'dart:convert';

// MULTISYS API
class MultisysApi {
  //Api for generate
  static const referenceApilUrl =
      "https://pgi-ws-staging.multipay.ph/api/v1/transactions";
  //Api for initialized
  final String initializeApilUrl =
      "https://pgi-ws-staging.multipay.ph/api/v1/transactions/generate";

  static const multipayToken = '2c1816316e65dbfcb0c34a25f3d6fe5589aef65d';
  static const multipayCode = 'MSYS_TEST_BILLER';
  static const callbackUrl = 'google.com'; //not final
  // final String contentType = 'application/json';

  // RETURNS STRING VALUE
  // NOT USED
  Future<String> postgenerateReference(
      String amount, String txnid, String digest, String callbackUrl) async {
    try {
      final responsegenerateReference =
          await http.post(referenceApilUrl, headers: {
        'X-MultiPay-Token': multipayToken,
        'X-MultiPay-Code': multipayCode,
        // 'Content-Type': contentType,
      }, body: {
        'amount': amount,
        'txnid': txnid,
        'digest': digest,
        'callbackUrl': callbackUrl,
      });
      print('server response: ' +
          responsegenerateReference.statusCode.toString());
      if (responsegenerateReference.statusCode == 200) {
        var refNo = jsonDecode(responsegenerateReference.body);
        var refNotoPass = refNo['data']['refno'];
        print(refNotoPass);
        return refNotoPass;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // RETURNS STRING VALUE OF URL
  Future<String> postinitializedTransaction(
      String amount, String txnid, String digest, String callbackUrl) async {
    try {
      final responseinitializedTransaction =
          await http.post(initializeApilUrl, headers: {
        'X-MultiPay-Token': multipayToken,
        'X-MultiPay-Code': multipayCode,
        // 'Content-Type': contentType,
      }, body: {
        'amount': amount,
        'txnid': txnid,
        'digest': digest,
        'callbackUrl': callbackUrl,
      });
      print('server response: ' +
          responseinitializedTransaction.statusCode.toString());
      if (responseinitializedTransaction.statusCode == 200) {
        final String responseString = responseinitializedTransaction.body;
        responseString.replaceAll("\/", "/");
        // print(jsonDecode(responseinitializedTransaction.body));
        var webViewRedirectUrl = jsonDecode(responseString);
        var apiUrl = webViewRedirectUrl['data']['url'];
        print(apiUrl);
        return apiUrl;
        // return transactionResponseModelFromJson(responseString);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // SEARCH THE TRANSACTION USING REF #
  // RETURNS STRING VALUE
  Future<String> getsearchTransaction(String refno) async {
    try {
      String getsearchTransactionApilUrl =
          "https://pgi-ws-staging.multipay.ph/api/v1/transactions/$refno";
      print(getsearchTransactionApilUrl);

      final responsesearchTransaction =
          await http.get(getsearchTransactionApilUrl, headers: {
        'X-MultiPay-Token': multipayToken,
        'X-MultiPay-Code': multipayCode,
      });

      print('server response: ' +
          responsesearchTransaction.statusCode.toString());
      if (responsesearchTransaction.statusCode == 200) {
        final responseString = json.decode(responsesearchTransaction.body);
        print(responseString);
        return responseString.toString();
      } else if (responsesearchTransaction.statusCode == 404) {
        final responseString = json.decode(responsesearchTransaction.body);
        print(responseString);
        return responseString.toString();
      } else if (responsesearchTransaction.statusCode == 405) {
        final responseString = json.decode(responsesearchTransaction.body);
        print(responseString);
        return responseString.toString();
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // VOID THE TRANSACTION USING REF #
  // RETURNS STRING VALUE
  Future<String> postvoidTransaction(String refno) async {
    try {
      String postvoidTransactionApilUrl =
          "https://pgi-ws-staging.multipay.ph/api/v1/transactions/$refno/void";
      print(postvoidTransactionApilUrl);

      final responsevoidTransaction =
          await http.post(postvoidTransactionApilUrl, headers: {
        'X-MultiPay-Token': multipayToken,
        'X-MultiPay-Code': multipayCode,
      });
      print(
          'server response: ' + responsevoidTransaction.statusCode.toString());
      if (responsevoidTransaction.statusCode == 200) {
        final responseString = json.decode(responsevoidTransaction.body);
        print(responseString);
        return responseString.toString();
      } else if (responsevoidTransaction.statusCode == 400) {
        final responseString = json.decode(responsevoidTransaction.body);
        print(responseString);
        return responseString.toString();
      } else if (responsevoidTransaction.statusCode == 403) {
        final responseString = json.decode(responsevoidTransaction.body);
        print(responseString);
        return responseString.toString();
      } else if (responsevoidTransaction.statusCode == 404) {
        final responseString = json.decode(responsevoidTransaction.body);
        print(responseString);
        return responseString.toString();
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
