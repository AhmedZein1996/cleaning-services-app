import 'package:clean_services_app/screens/OrderHistory/components/body.dart';
import 'package:clean_services_app/utilities/shared.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  static String routeName = "/order_history";

  const OrderHistoryScreen({Key? key}) : super(key: key);

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
              localLanguageStrings(context).orders,
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
