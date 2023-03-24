import 'package:clean_services_app/screens/ScratchingCards/components/body.dart';
import 'package:flutter/material.dart';

class ScratchingScreen extends StatelessWidget {
  const ScratchingScreen({Key? key}) : super(key: key);
  static const String routeName = 'scratching-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
