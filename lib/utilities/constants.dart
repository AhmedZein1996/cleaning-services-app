import 'package:flutter/material.dart';

import 'enums.dart';

const kPrimaryColor = Colors.blue;
//const kPrimaryColor = Color(0xFF6F35A5);
//const kPrimaryLightColor =  Colors.blue.shade50;
final Color kLightBlue = Colors.blue.shade50;
const String kInvalidEmailMessage = "invalid email";
const kInvalidEmailBecauseSpecialCharMessage =
    "invalid email, Special character not allowed ";
const kValidEmailMessage = "valid email";
const kValidPasswordMessage = "valid password";
const defaultLanguageKey = "default Language";
const defaultThemeModeKey = "default Theme";
const kTokenKey = "access_token";
const notFoundError = "not found";
const kLoginFinishedWithError = "error Login";
const kLoginFinishedWithoutError = "successful login";
const kInvalidPasswordMessage =
    "invalid password, paswword must have at least 7 length ";

TextInputType inputType(KeyboardType keyType) {
  switch (keyType) {
    case KeyboardType.numbers:
      return TextInputType.number;
      break;
    case KeyboardType.text:
      return TextInputType.text;
      break;
    case KeyboardType.email:
      return TextInputType.text;
      break;
  }
  return TextInputType.text;
}

const int statusCode_compelete = 200; // complete
int statusCode_awaiting_payment = 100; // awaiting payment
int statusCode_cancelled = 500; // cancelled
int statusCode_finished = 300; // finished
int statusCode_awaiting_serve = 400; // awaiting serve
