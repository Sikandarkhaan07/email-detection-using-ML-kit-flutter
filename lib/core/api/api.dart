import 'package:http/http.dart' as http;

//this API is only use for email verification.
class APIs {
  static const apiKey = '4fnpHoLtffOG0n6yyBRaI2l7NqaXpiOF';
  static const baseUrl =
      'https://api.apilayer.com/email_verification/check?email=';

  static Future<String> getResponse(String email) async {
    final resp = await http.get(Uri.parse('$baseUrl$email'), headers: {
      'apikey': apiKey,
    });
    if (resp.statusCode == 200) {
      return resp.body;
    } else {
      return '';
    }
  }
}
