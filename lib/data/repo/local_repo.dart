import 'dart:convert';

import 'package:code_test/model/phone_verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepo {
  static final LocalRepo _lcoalRepo = LocalRepo._internal();
  static const _key_phone_verification = 'KEY_PHONE_VERIFICATION';
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  factory LocalRepo() {
    return _lcoalRepo;
  }

  LocalRepo._internal();

  Future<void> setPhoneVerification(PhoneVerification pv) async {
    final SharedPreferences prefs = await _prefs;
    List<PhoneVerification> pvList = await getPhoneVerification();
    pvList.add(pv);
    prefs.setString(_key_phone_verification, jsonEncode(pvList));
  }

  Future<List<PhoneVerification>> getPhoneVerification() async {
    final SharedPreferences prefs = await _prefs;
    String phString = prefs.getString(_key_phone_verification) ?? "[]";
    var pvList = jsonDecode(phString) as List;
    return pvList.map((e) => PhoneVerification.fromJson(e)).toList();
  }
}
