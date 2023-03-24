// ignore_for_file: file_names

import 'package:clean_services_app/Screens/Order/order_screen.dart';
import 'package:clean_services_app/model/service.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String? title;
  final String? assetLink;
  final String? description;
  final String? serviceId;
  final List<Regulation> regulations;

  const GridItem({
    required this.title,
    required this.assetLink,
    required this.description,
    required this.serviceId,
    required this.regulations,
  });

  void selectedService(context) {
    Navigator.of(context).pushNamed(
      OrderScreen.routeName,
      arguments: {
        'service_id': serviceId,
        'service_name': title,
        'service_desc': description,
        'service_regulations': regulations,
      },
    );
  }
  /*void selectedService(context) {
    globalClient
        .query(
      QueryOptions(
        document: gql(durationQuery),
        variables: {
          "service_id": serviceId,
          "regulation_id": regulations,
        },
      ),
    )
        .then((QueryResult result) {
      //log('duration : ${result.data.toString()}');
      ServiceDuration duration = CleaningServices.durations(result.data);
      log('minimum_hours : ${duration.minimumHours}');
      Navigator.of(context).pushNamed(
        OrderScreen.routeName,
        arguments: {
          'service_id': serviceId,
          'service_name': title,
          'service_regulations': regulations,
        },
      );
    }).catchError(
      (error) {
        log("$error");
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    //عدلت هنا
    return GestureDetector(
      onTap: () => selectedService(context),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Image.network(
                      "$assetLink",
                      fit: BoxFit.fill,
                      height: 100,
                      width: 180,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.arrow_forward_sharp,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
