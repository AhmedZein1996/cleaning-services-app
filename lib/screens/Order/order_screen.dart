import 'package:clean_services_app/model/service.dart';
import 'package:clean_services_app/Screens/Order/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = "/order-screen";

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String?, dynamic>;
    String? serviceName = routeArgs['service_name'];
    String? serviceId = routeArgs['service_id'];
    String? serviceTitle = routeArgs['service_name'];
    String? serviceDescription= routeArgs['service_desc'];
    final List<Regulation> regulations = routeArgs['service_regulations'];

    //String hintText = 'm\u{00B2}';
    return Scaffold(
        appBar: AppBar(
          title: Text(serviceName.toString()),
        ),
        body: Body(
          serviceId: serviceId,
          regulations: regulations,
          serviceTitle: serviceTitle,
          serviceDescription: serviceDescription,

        ));
  }
}
