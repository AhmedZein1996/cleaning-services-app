import 'package:clean_services_app/Firebase/firebase_functions.dart';
import 'package:clean_services_app/Screens/Login/components/sign_form.dart';
import 'package:clean_services_app/Screens/Signup/signup_screen.dart';
import 'package:clean_services_app/components/already_have_an_account_acheck.dart';
import 'package:clean_services_app/provider/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/or_divider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseProvider =
        Provider.of<FirebaseFunctions>(context, listen: true);

    Size size = MediaQuery.of(context).size;
    return Center(
      child: firebaseProvider.isLoading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
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
                  const Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  const SignForm(),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerRight,
                    width: size.width * 0.8,
                    child: Text(
                      "forgot password?",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),

                  // ignore: prefer_const_constructors
                  OrDivider(),
                  Text(
                    "login using",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          firebaseProvider.googleLogin(context);
                          // firebaseSignIn.logOut();
                        },
                        child: Image.asset(
                          "assets/images/google.png",
                          height: 25,
                          width: 25,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          primary: Colors.white,
                          elevation: 5,
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      /*ElevatedButton(
                  onPressed: () {},
                  child: Image.asset(
                    "assets/images/apple.png",
                    height: 25,
                    width: 25,

                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: Colors.white,
                    elevation: 5,
                    padding: const EdgeInsets.all(10.0),
                  ),
                ),*/
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
