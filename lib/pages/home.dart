import 'dart:developer';

import 'package:code_test/model/country_code.dart';
import 'package:flutter/material.dart';
import 'package:code_test/widgets/phone_input_form.dart';
import 'package:code_test/enums/Path.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Code test'),
          actions: [
            IconButton(
              icon: new Icon(Icons.history),
              onPressed: () {
                Navigator.pushNamed(context, Path.attemptHistory.getPath());
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo-livi.png',
                    height: 150, width: 150),
                SizedBox(height: 16.0),
                PhoneInputForm(() {
                  Navigator.pushNamed(context, Path.attemptHistory.getPath());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
