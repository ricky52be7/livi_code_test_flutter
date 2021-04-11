import 'package:code_test/data/repo/local_repo.dart';
import 'package:code_test/model/phone_verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttemptHistory extends StatelessWidget {
  final LocalRepo _localRepo = LocalRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validation History'),
      ),
      body: FutureBuilder<List<PhoneVerification>>(
        future: _localRepo.getPhoneVerification(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${snapshot.data![index].countryCode!.dialCode} ${snapshot.data![index].phoneNo}"),
                      snapshot.data![index].isValid!
                          ? Text('Vaild')
                          : Text('Invaild',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: Column(
              children: [Text('No attempted data found')],
            ),
          );
        },
      ),
    );
  }
}
