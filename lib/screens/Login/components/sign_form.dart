import 'dart:developer';

import 'package:clean_services_app/Screens/Home/home_screen.dart';
import 'package:clean_services_app/components/form_error.dart';
import 'package:clean_services_app/components/rounded_button.dart';
import 'package:clean_services_app/components/rounded_input_field.dart';
import 'package:clean_services_app/components/rounded_password_field.dart';
import 'package:clean_services_app/screens/FirstTimeUserAppear/first_time_user_screen.dart';
import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../utilities/regexp_validation.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
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
        errorList.remove(error);
      });
    }
  }

  String resultChecking(dynamic result) {
    String message;
    if (result.data == null) {
      message = "The user credentials were incorrect";
      addError(
        error: message,
      );
      log(message);

      return message;
    } else {
      message = "Success";
      removeError(error: "The user credentials were incorrect");
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
              removeError(error: "The user credentials were incorrect");
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              }
              if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
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
              removeError(error: "The user credentials were incorrect");
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
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
          _isLoading
              ? const CircularProgressIndicator()
              : RoundedButton(
                  text: 'Login',
                  press: () {
                    //removeError(error: "The user credentials were incorrect");
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
                          document: gql(mutationLogin),
                          variables: {"username": email, "password": password},
                        ),
                      )
                          .then(
                        (result) {
                          setState(
                            () {
                              _isLoading = false;
                            },
                          );
                          log(result.toString());
                          if (resultChecking(result) == "Success") {
                            CachedHelper.putValue("access_token",
                                result.data!['login']['access_token']);
                            if (CachedHelper.isGiftTaken()) {
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName);
                            } else {
                              Navigator.of(context).pushReplacementNamed(
                                  FirstTimeUserScreen.routeName);
                            }
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
//
