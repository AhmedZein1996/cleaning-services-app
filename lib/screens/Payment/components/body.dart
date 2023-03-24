import 'dart:developer';

import 'package:clean_services_app/provider/cleaning_information.dart';
import 'package:clean_services_app/provider/user_informatin.dart';
import 'package:clean_services_app/screens/Payment/components/methodElement.dart';
import 'package:clean_services_app/screens/Payment/components/payment_web_view.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, dynamic>> userPets(UserInformationModel userInformation) {
    List<Map<String, dynamic>> pets = [];
    Map<String, dynamic> haveCats = {"type": "cats", "number": 1};
    Map<String, dynamic> haveDogs = {"type": "dogs", "number": 1};
    Map<String, dynamic> haveOtherPets = {"type": "others", "number": 1};
    if (userInformation.isHaveCats) {
      pets.add(haveCats);
    }
    if (userInformation.isHaveDogs) {
      pets.add(haveDogs);
    }
    if (userInformation.isHaveOtherPets) {
      pets.add(haveOtherPets);
    }
    return pets;
  }

  void addOrder(BuildContext context, UserInformationModel userInformation,
      CleaningInformation cleaningInformation, String paymentMethod) {
    log('datae of serve  ${cleaningInformation.dateOfServe.toString().split('.').first}');
    log('datae of ID  ${cleaningInformation.dateOfServeId}');
    List<Map<String, dynamic>> pets = userPets(userInformation);
    log('$pets');
    log("${cleaningInformation.selectedRegulation.title}||||||||||||||||${cleaningInformation.selectedRegulation.id}");
    log("  service_id: ${cleaningInformation.serviceId}");
    log("  regulation_id: ${cleaningInformation.selectedRegulation.id}");
    log("  time_to_serve: ${double.parse(cleaningInformation.timeToServe)}");
    log("  date_of_serve: ${int.parse(cleaningInformation.dateOfServeId)}");
    log("  apartment_size: ${double.parse(cleaningInformation.apartmentSize)}");
    log("  payment_way: ${paymentMethod}");
    log("  street_info: ${userInformation.streetAddress}");
    log("  postcode: ${userInformation.postCode}");
    log("  PID: ${userInformation.identityNumber}");
    log("  first_name: ${userInformation.firstName}");
    log("  last_name: ${userInformation.lastName}");
    log("  phone: ${userInformation.phone}");
    log("  email: ${userInformation.email}");

    globalClient
        .mutate(
      MutationOptions(
        document: gql(
          createOrderMutation,
        ),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          "service_id": cleaningInformation.serviceId,
          "regulation_id": cleaningInformation.selectedRegulation.id,
          "time_to_serve": double.parse(cleaningInformation.timeToServe),
          /* "date_of_serve":
              cleaningInformation.dateOfServe.toString().split('.').first,*/
          "date_of_serve": int.parse(cleaningInformation.dateOfServeId),
          "apartment_size": double.parse(cleaningInformation.apartmentSize),
          "is_without_RUT": false,
          "payment_way": paymentMethod,
          "street_info": userInformation.streetAddress,
          "postcode": userInformation.postCode,
          "PID": userInformation.identityNumber,
          "first_name": userInformation.firstName,
          "last_name": userInformation.lastName,
          "phone": userInformation.phone,
          "email": userInformation.email,
          "pets": pets
        },
      ),
    )
        .then((result) {
      log("Create Order Response : --> ${result}");
      Navigator.of(context).pushNamed(PaymentWebView.routeName, arguments: {
        "url": "${result.data!['createOrder']['url']}",
        "pageNamed": paymentMethod
      });
    }).catchError((error) {
      log("Create Order Error Response : --> ${error}");
    });
    /* Provider.of<OrdersProvider>(context, listen: false).addOrder(
      cleaningInformation: cleaningInformation,
      userInformation: userInformation,
    );
    Fluttertoast.showToast(
        msg: 'The order is done successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);*/
  }

  @override
  Widget build(BuildContext context) {
    final userInformation =
        Provider.of<UserInformationProvider>(context, listen: false)
            .userInformation;
    final cleaningInformation =
        Provider.of<CleaningInformationProvider>(context, listen: false)
            .cleaningInformation;
    return SingleChildScrollView(
      child: Column(
        children: [
          MethodElement(
            assetLink: "assets/images/paypal.png",
            methodName: "Paypal",
            onPress: () => addOrder(
                context, userInformation, cleaningInformation!, "PAYPAL"),
          ),
          MethodElement(
            assetLink: "assets/images/visacard.png",
            methodName: "Visa",
            onPress: () => addOrder(
                context, userInformation, cleaningInformation!, "STRIPE"),
          ),
          MethodElement(
            assetLink: "assets/images/mastercard.png",
            methodName: "Master Card",
            onPress: () => addOrder(
                context, userInformation, cleaningInformation!, "STRIPE"),
          ),
        ],
      ),
    );
  }
}
