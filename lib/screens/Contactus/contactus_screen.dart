import 'package:clean_services_app/Screens/Contactus/components/body.dart';
import 'package:clean_services_app/utilities/shared.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  static String routeName = "/contactus";

  const ContactUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localLanguageStrings(context).contactUs,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Body(),
    );
  }
}
