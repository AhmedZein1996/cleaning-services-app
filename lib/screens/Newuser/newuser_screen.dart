import 'package:clean_services_app/screens/Newuser/components/body.dart';
import 'package:flutter/material.dart';

class NewUserScreen extends StatelessWidget {
  static const String routeName = 'newuser_screen';

  const NewUserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
