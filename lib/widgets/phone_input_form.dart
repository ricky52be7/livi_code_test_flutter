import 'dart:async';
import 'dart:developer';

import 'package:code_test/data/repo/local_repo.dart';
import 'package:code_test/data/repo/twilio_repo.dart';
import 'package:code_test/data/response/twilio_phonen_umber_response.dart';
import 'package:code_test/model/country_code.dart';
import 'package:code_test/model/phone_verification.dart';
import 'package:code_test/utils/common_utils.dart';
import 'package:code_test/utils/country_code_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputForm extends StatefulWidget {
  final Function callback;

  PhoneInputForm(this.callback);

  @override
  _PhoneInputFormState createState() => _PhoneInputFormState();
}

class _PhoneInputFormState extends State<PhoneInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _menuKey = GlobalKey();
  final _twilioRepo = TwilioRepo();
  final _LocalRepo = LocalRepo();
  late TextEditingController _countryCodeController;
  late TextEditingController _phoneNoController;
  late Future<List<CountryCode>> _futureCountryCode;
  String? searchText;
  CountryCode? selectedCountryCode;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _futureCountryCode = CountryCodeUtils.getCountryCodes();
    _countryCodeController = new TextEditingController();
    _phoneNoController = new TextEditingController();
  }

  @override
  void dispose() {
    _countryCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _formKey,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [BoxShadow()],
          ),
          child: Row(
            children: [
              FutureBuilder<List<CountryCode>>(
                future: _futureCountryCode,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (selectedCountryCode == null) {
                      // initial setup
                      selectedCountryCode = snapshot.data![snapshot.data!
                          .indexWhere((element) => element.dialCode == '+852')];
                      if (selectedCountryCode!.dialCode != null)
                        _countryCodeController.text =
                            selectedCountryCode!.dialCode!;
                    }
                    return PopupMenuButton(
                      key: _menuKey,
                      initialValue: selectedCountryCode,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50.0,
                            child: TextFormField(
                              decoration:
                                  new InputDecoration(border: InputBorder.none),
                              // initialValue: selectedCountryCode.dialCode,
                              controller: _countryCodeController,
                              onChanged: (value) => setState(() {
                                searchText = value;

                                if (_timer != null) {
                                  _timer!.cancel();
                                }
                                _timer = Timer(Duration(seconds: 1), () {
                                  dynamic state = _menuKey.currentState;
                                  state.showButtonMenu();
                                });
                              }),
                              onEditingComplete: () {},
                            ),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      itemBuilder: (context) => snapshot.data!
                          .where((element) {
                            if (searchText != null && searchText!.isNotEmpty) {
                              return element.dialCode!.contains(searchText!) ||
                                  element.name!.contains(searchText!);
                            }
                            return true;
                          })
                          .map((e) => PopupMenuItem(
                                value: e,
                                child: Text('${e.alpha2} ${e.dialCode}'),
                              ))
                          .toList(),
                      onSelected: (CountryCode value) {
                        log('${value.dialCode}');
                        setState(() {
                          _countryCodeController.text = value.dialCode!;
                          selectedCountryCode = value;
                        });
                      },
                    );
                  }
                  return Text("");
                },
              ),
              Expanded(
                child: TextFormField(
                  controller: _phoneNoController,
                  decoration: new InputDecoration(border: InputBorder.none),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onEditingComplete: () async {
                    _submit();
                  },
                ),
              )
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            _submit();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  _submit() async {
    if (selectedCountryCode != null && _phoneNoController.text.isNotEmpty) {
      TwilioPhoneNumberResponse? response = await _twilioRepo.verifyPhoneNumber(
          selectedCountryCode!.dialCode!, _phoneNoController.text);

      PhoneVerification pv = PhoneVerification(
          countryCode: selectedCountryCode,
          phoneNo: _phoneNoController.text,
          isValid: response != null);
      _LocalRepo.setPhoneVerification(pv);

      if (response != null) {
        widget.callback();
      } else {
        _showPhoneNumberError(context);
      }
    } else {
      // not vaild phone number
      _showPhoneNumberError(context);
    }
  }

  _showPhoneNumberError(BuildContext context) {
    CommonUtils.showAlertDialog(
        context: context,
        title: 'Error',
        message: 'Phone Number not found, Please try again');
  }
}
