import 'package:clean_services_app/Screens/Welcome/components/body.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = "/welcome";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
