import 'package:clean_services_app/Screens/Login/components/body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/log_in";

  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(

      body: Body(),
    );
  }
}
