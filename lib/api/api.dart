import 'dart:developer';

import 'package:http/http.dart' as http;

class APIs {
  static const apiKey = '4fnpHoLtffOG0n6yyBRaI2l7NqaXpiOF';
  static const baseUrl =
      'https://api.apilayer.com/email_verification/check?email=sikandarkhaan07@gmail.com';

  static Future<void> getResponse() async {
    final resp = await http.get(Uri.parse(baseUrl), headers: {
      'apikey': apiKey,
    });
    if (resp.statusCode == 200) {
      log('\nsuccessful');
      log('\nResponse: ${resp.body}');
    }
  }
}
