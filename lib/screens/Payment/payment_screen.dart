import 'package:flutter/material.dart';

import 'components/body.dart';

class PaymentScreen extends StatelessWidget {
  static const String routeName = 'payment-screen';
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
        ),
        body: const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Body(),
        ));
  }
}
