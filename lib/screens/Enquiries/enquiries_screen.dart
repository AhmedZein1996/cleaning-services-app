import 'package:clean_services_app/screens/Enquiries/components/body.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class EnquiriesScreen extends StatelessWidget {
  static String routeName = "/enquiries";

  const EnquiriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
