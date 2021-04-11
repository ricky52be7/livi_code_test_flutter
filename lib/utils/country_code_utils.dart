import 'dart:convert';

import 'package:code_test/model/country_code.dart';
import 'package:flutter/services.dart';

class CountryCodeUtils {
  static Future<List<CountryCode>> getCountryCodes() async {
    String data = await rootBundle.loadString("assets/country_code.json");
    List<dynamic> countryCodeList = jsonDecode(data);
    return countryCodeList.map((e) => CountryCode.fromJson(e)).toList();
  }
}
