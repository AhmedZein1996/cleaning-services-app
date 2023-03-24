import 'package:clean_services_app/Firebase/firebase_functions.dart';
import 'package:clean_services_app/Screens/Contactus/contactus_screen.dart';
import 'package:clean_services_app/Screens/Profile/components/profile_menu.dart';
import 'package:clean_services_app/Screens/Welcome/welcome_screen.dart';
import 'package:clean_services_app/components/coustom_bottom_nav_bar.dart';
import 'package:clean_services_app/screens/Newuser/newuser_screen.dart';
import 'package:clean_services_app/screens/settings/settings_screen.dart';
import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:clean_services_app/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseSignIn =
        Provider.of<FirebaseFunctions>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => Navigator.of(context).pushNamed(NewUserScreen.routeName),
            ),
//
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () =>
                  Navigator.of(context).pushNamed(SettingsScreen.routeName),
            ),
            ProfileMenu(
              text: "Contact Us",
              icon: "assets/icons/Question mark.svg",
              press: () =>
                  Navigator.of(context).pushNamed(ContactUsScreen.routeName),
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                //   Navigator.pop(context);
                Navigator.of(context)
                    .pushReplacementNamed(WelcomeScreen.routeName);
                firebaseSignIn.logOut();
                CachedHelper.logout();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
