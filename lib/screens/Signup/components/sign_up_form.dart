import 'dart:developer';

import 'package:clean_services_app/Screens/Login/login_screen.dart';
import 'package:clean_services_app/components/form_error.dart';
import 'package:clean_services_app/components/rounded_button.dart';
import 'package:clean_services_app/components/rounded_input_field.dart';
import 'package:clean_services_app/components/rounded_password_field.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../utilities/regexp_validation.dart';

class SignUpForm extends StatefulWidget {
  String? test;

  SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String createdAt = '';
  String password = '';
  String confirmPassword = '';
  String status = '';
  final List<String> errorList = [];

  void addError({String? error}) {
    if (!errorList.contains(error)) {
      setState(() {
        errorList.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errorList.contains(error)) {
      setState(() {
        errorList.remove(error!);
      });
    }
  }

  String resultChecking(dynamic result) {
    String message;
    if (result.data == null) {
      message = "email has already been taken";
      addError(
        error: message,
      );
      log(message);
      return message;
    } else {
      message = "Success";
      removeError(error: "email has already been taken");
      log(message);
      return message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          RoundedInputField(
            hintText: "Your Email",
            onSaved: (newValue) => email = newValue!,
            validator: (String? value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return '';
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return '';
              }
              return null;
            },
            onChanged: (value) {
              removeError(error: "email has already been taken");
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              }
              if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              email = value;
            },
          ),
          RoundedPasswordField(
            hint: "Password",
            onSaved: (newValue) => password = newValue!,
            validator: (String? value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return '';
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return '';
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
          ),
          RoundedPasswordField(
            hint: "Confirm Password",
            onSaved: (newValue) => confirmPassword = newValue!,
            validator: (value) {
              if (value.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if ((password != value)) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (value.isNotEmpty && password == value) {
                removeError(error: kMatchPassError);
              }
              confirmPassword = value;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          FormError(
            errors: errorList,
          ),
          const SizedBox(
            height: 10,
          ),
          /*const SizedBox(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
            height: 30,
            width: 30,
          ),*/
          _isLoading
              ? const CircularProgressIndicator()
              : RoundedButton(
                  text: "SIGNUP",
                  press: () {
                   // removeError(error: "email has already been taken");
                    if (_formKey.currentState!.validate() &&
                        errorList.isEmpty) {
                      _formKey.currentState!.save();

                      setState(
                        () {
                          _isLoading = true;
                        },
                      );

                      globalClient
                          .mutate(
                        MutationOptions(
                          document: gql(mutationRegister),
                          variables: {
                            "name": "noName",
                            "email": email,
                            "password": password,
                            "password_confirmation": confirmPassword
                          },
                        ),
                      )
                          .then(
                        (result) {
                          setState(
                            () {
                              _isLoading = false;
                            },
                          );
                          if (resultChecking(result) == "Success") {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          }
                          // log(message.toString());
                        },
                      ).catchError(
                        (error) {
                          log("$error");
                        },
                      );
                    }
                  },
                ),
        ],
      ),
    );
  }
}
