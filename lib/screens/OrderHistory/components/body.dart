import 'package:clean_services_app/components/coustom_bottom_nav_bar.dart';
import 'package:clean_services_app/provider/orders.dart';
import 'package:clean_services_app/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_widget.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    Provider.of<OrdersProvider>(context, listen: false).fetchOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return ordersProvider.isLoading
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
            bottomNavigationBar:
                const CustomBottomNavBar(selectedMenu: MenuState.orders),
          )
        : ordersProvider.orders.isEmpty
            ? Scaffold(
                body: const Center(
                  child: Text(
                    'There is no orders yet let\'s add some orders',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                bottomNavigationBar:
                    const CustomBottomNavBar(selectedMenu: MenuState.orders),
              )
            : Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: ordersProvider.orders
                          .map(
                            (orderItem) => OrderWidget(
                              orderItem: orderItem,
                            ),
                          )
                          .toList(),
                      //const SizedBox(height: 10,),
                    ),
                  ),
                ),
                bottomNavigationBar:
                    const CustomBottomNavBar(selectedMenu: MenuState.orders),
              );
  }
}
