import 'package:flutter/material.dart';

import 'components/body.dart';

class FirstTimeUserScreen extends StatelessWidget {
  const FirstTimeUserScreen({Key? key}) : super(key: key);
  static const String routeName = 'first-time-user-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
