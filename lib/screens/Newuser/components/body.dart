import 'package:clean_services_app/screens/Home/home_screen.dart';
import 'package:clean_services_app/screens/Newuser/components/newuser_widget.dart';
import 'package:clean_services_app/screens/OrderHistory/order_history_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Column(
          children: [
            NewUserWidget(
              title: 'nerasta jokiu uzaskmu',
              description: 'neturejia jokiu nymu',
              buttuonText: 'New Client',
              onPressed: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
            ),
            const SizedBox(height: 15),
            NewUserWidget(
              title: 'As esu klient',
              description: 'Greit bus jusu mas ? ar turejote valyme pas ?',
              buttuonText: 'Aleardy Client',
              onPressed: () {
                Navigator.of(context).pushNamed(OrderHistoryScreen.routeName);
              },
            ),

          ],
        ),
      ),
    );
  }
}
