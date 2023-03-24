import 'package:clean_services_app/utilities/shared.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Color(0XFF8B8B8B),
          fontSize: 18,
        ),
      ),*/
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localLanguageStrings(context).profile,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: DoubleBackToCloseApp(
        child: Body(),
        snackBar: SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Theme.of(context).textTheme.button!.color,
          content: Container(
              height: 28,
              child: Text('Tap back again to leave',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).scaffoldBackgroundColor))),
        ),
      ),
    );
  }
}
