// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:clean_services_app/Screens/Home/components/body.dart';
import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    log("Token : ${CachedHelper.getValue(kTokenKey)}");
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

/*
BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label:'hola',
            icon: Icon(Icons.access_alarm),
          ), BottomNavigationBarItem(
            label:'hola',
            icon: Icon(Icons.access_alarm),
          ),
        ],
      ),
      */
