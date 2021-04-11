import 'package:flutter/cupertino.dart';

class CountryCode {
  String? dialCode;
  String? flag;
  String? alpha2;
  String? name;

  CountryCode(
      {@required this.dialCode,
      @required this.flag,
      @required this.alpha2,
      @required this.name});

  CountryCode.fromJson(Map<String, dynamic> json)
      : dialCode = json['dialCode'],
        flag = json['flag'],
        alpha2 = json['alpha2'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'dialCode': dialCode,
        'flag': flag,
        'alpha2': alpha2,
        'name': name,
      };
}
