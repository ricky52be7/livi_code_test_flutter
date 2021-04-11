import 'package:flutter/cupertino.dart';

class TwilioPhoneNumberResponse {
  // String? callerName;
  String? countryCode;
  String? phoneNo;
  // String? nationalFormat;
  // String? carrier;
  // String? addOns;
  // String? url;

  TwilioPhoneNumberResponse(
      {@required this.countryCode, @required this.phoneNo});

  TwilioPhoneNumberResponse.fromJson(Map<String, dynamic> json)
      : countryCode = json['country_code'],
        phoneNo = json['phoneNo'];

  Map<String, dynamic> toJson() => {
        'country_code': countryCode,
        'phone_number': phoneNo,
      };
}
