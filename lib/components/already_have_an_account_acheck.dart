import 'package:clean_services_app/utilities/constants.dart';
import 'package:clean_services_app/utilities/shared.dart';
import 'package:flutter/material.dart';



class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? localLanguageStrings(context).dont_have_account : localLanguageStrings(context).already_have_an_account,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        GestureDetector(
          onTap: () => press(),
          child: Text(
            login ? "Sign Up" : "Sign In", // TODO: add this to inl_en
              style:  const TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
    //TextStyle(
//              color: kPrimaryColor,
//              fontWeight: FontWeight.bold,
//            ),
          ),
        )
      ],
    );
  }
}
