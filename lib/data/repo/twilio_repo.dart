import 'dart:convert';
import 'dart:developer';

import 'package:code_test/data/response/twilio_phonen_umber_response.dart';
import 'package:http/http.dart';

class TwilioRepo {
  static final TwilioRepo _twilioRepo = TwilioRepo._internal();
  final String _baseUrl = 'https://lookups.twilio.com';
  final String _user = 'ACc6391cf47021f0cdf21936a500016593';
  final String _pw = 'd15c37164d2d2a6aedf4dfd6f6ea154a';

  factory TwilioRepo() {
    return _twilioRepo;
  }

  TwilioRepo._internal();

  Map<String, String> _getHeader() {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pw'));
    return {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };
  }

  Future<TwilioPhoneNumberResponse?> verifyPhoneNumber(
      String countryCode, String phoneNo) async {
    var url = Uri.parse('$_baseUrl/v1/PhoneNumbers/$countryCode$phoneNo');
    final response = await get(url, headers: _getHeader());
    if (response.statusCode == 200) {
      log('vaild phone no: $countryCode$phoneNo');
      final parsed = json.decode(response.body);
      return TwilioPhoneNumberResponse.fromJson(parsed);
    } else {
      log('invaild phone no: $countryCode$phoneNo');
      return null;
    }
  }
}
