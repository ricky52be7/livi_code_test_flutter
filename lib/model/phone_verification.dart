import 'package:code_test/model/country_code.dart';
import 'package:flutter/cupertino.dart';

class PhoneVerification {
  CountryCode? countryCode;
  String? phoneNo;
  bool? isValid;

  PhoneVerification(
      {@required this.countryCode,
      @required this.phoneNo,
      @required this.isValid});

  PhoneVerification.fromJson(Map<String, dynamic> json)
      : countryCode = CountryCode.fromJson(json['countryCode']),
        phoneNo = json['phoneNo'],
        isValid = json['isValid'];

  Map<String, dynamic> toJson() => {
        'countryCode': countryCode?.toJson(),
        'phoneNo': phoneNo,
        'isValid': isValid,
      };
}
