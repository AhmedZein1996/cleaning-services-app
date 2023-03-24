import 'dart:developer';

import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  String feedback = '';
  TextEditingController controller = TextEditingController();
  sendFeedback() {
    if (feedback.isEmpty) {
      return;
    }
    globalClient
        .mutate(
      MutationOptions(
        document: gql(createFeedbackMutation),
        variables: {"content": feedback},
      ),
    )
        .then((result) {
      log('feedback created by user : ${result.data}');
      Fluttertoast.showToast(
          msg: 'you\'r feedback has been sent.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError(
      (error) {
        log("$error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.05,
            bottom: size.height * 0.05,
            right: size.width * 0.08,
            left: size.width * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FittedBox(
                child: Text(
                  "Let us know how to improve our app",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 22,
                    //color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              TextField(
                controller: controller,
                onChanged: (newValue) {
                  feedback = newValue;
                },
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                    ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 25),
                    hintText: 'Enter Your Feedback',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey),
                    )),
                maxLines: 8,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  sendFeedback();
                },
                child: Container(
                  margin: EdgeInsets.only(
                    right: width * 0.035,
                    left: width * 0.035,
                    top: height * 0.015,
                    bottom: height * 0.1,
                  ),
                  height: height * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
