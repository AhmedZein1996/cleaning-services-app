import 'package:clean_services_app/Screens/Enquiries/enquiries_screen.dart';
import 'package:clean_services_app/Screens/Home/home_screen.dart';
import 'package:clean_services_app/Screens/Profile/profile_screen.dart';
import 'package:clean_services_app/screens/OrderHistory/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomBottomNavBar({
    required this.selectedMenu,
  });

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).textTheme.button!.color;
    //final size = MediaQuery.of(context).size;
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: Theme.of(context).hoverColor,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? iconColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/receipt.svg",
                  color: MenuState.orders == selectedMenu
                      ? iconColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, OrderHistoryScreen.routeName);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Question mark.svg",
                  color: MenuState.messages == selectedMenu
                      ? iconColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, EnquiriesScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? iconColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, ProfileScreen.routeName),
//                    await User.isAlreadyLogin() ? Navigator.pushNamed(context, ProfileScreen.routeName) :
//                    Navigator.pushReplacementNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
