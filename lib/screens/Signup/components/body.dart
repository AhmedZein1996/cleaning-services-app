import 'package:clean_services_app/Firebase/firebase_functions.dart';
import 'package:clean_services_app/Screens/Login/login_screen.dart';
import 'package:clean_services_app/Screens/Signup/components/sign_up_form.dart';
import 'package:clean_services_app/components/already_have_an_account_acheck.dart';
import 'package:clean_services_app/provider/app_theme.dart';
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
                    "SIGNUP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SignUpForm(),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /*              SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  imageType: ImageType.PNG,
                  iconSrc: "assets/images/apple.png",
                  press: () {},
                ),*/
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
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
