import 'package:clean_services_app/Screens/Login/login_screen.dart';
import 'package:clean_services_app/Screens/Signup/signup_screen.dart';
import 'package:clean_services_app/components/rounded_button.dart';
import 'package:clean_services_app/provider/app_theme.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<AppTheme>(
            builder: (BuildContext context, appTheme, Widget? _) =>
                appTheme.isDark
                    ? Image.asset(
                        "assets/logo_dark.png",
                        height: 200,
                      )
                    : Image.asset(
                        "assets/LogoColorNoText.jpeg",
                        height: 200,
                      ),
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
          RoundedButton(
            text: "SIGN UP",
            color: kLightBlue,
            textColor: Colors.black,
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
