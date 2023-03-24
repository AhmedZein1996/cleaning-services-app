import 'package:clean_services_app/provider/user_informatin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({Key? key}) : super(key: key);

/*  addOrder(BuildContext context, UserInformationModel userInformation,
      CleaningInformation cleaningInformation) {
    globalClient
        .mutate(MutationOptions(document: gql(createOrderMutation), variables: {
      "service_id": cleaningInformation.serviceId,
      "regulation_id": cleaningInformation.selectedRegulation.id,
      "time_to_serve": double.parse(cleaningInformation.timeToServe),
      "apartment_size": double.parse(cleaningInformation.apartmentSize),
      "is_without_RUT": false,
      "payment_way": "PAYPAL",
      "street_info": userInformation.streetAddress,
      "postcode": userInformation.postCode,
      "PID": userInformation.identityNumber,
      "first_name": userInformation.firstName,
      "last_name": userInformation.lastName,
      "phone": userInformation.phone,
      "email": userInformation.email
    }))
        .then((result) {
      log("Create Order Response : --> ${result}");
    }).catchError((error) {
      log("Create Order Error Response : --> ${error}");
    });
    Provider.of<OrdersProvider>(context, listen: false).addOrder(
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
        fontSize: 16.0);
  }*/

  @override
  Widget build(BuildContext context) {
    final userInformation =
        Provider.of<UserInformationProvider>(context, listen: false)
            .userInformation;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const Text(
          'Your information',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        TableRow(
          width: width,
          label: 'Email',
          text: userInformation.email,
          isTopContainer: true,
        ),
        TableRow(
          width: width,
          label: 'Postalcode',
          text: userInformation.postCode,
        ),
        SizedBox(
          width: width * .8,
          child: Row(
            children: [
              Container(
                width: width * .4,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                    left: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First name',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      userInformation.firstName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * .4,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                    left: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'last name',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      userInformation.lastName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TableRow(
          width: width,
          label: 'Address',
          text: userInformation.streetAddress,
        ),
        TableRow(
          width: width,
          label: 'Identity number',
          text: userInformation.identityNumber,
        ),
        TableRow(
          width: width,
          label: 'Phone',
          text: userInformation.phone,
        ),
        SizedBox(
          height: height * .025,
        ),
        /* GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(PaymentScreen.routeName);
            addOrder(context, userInformation, cleaningInformation!);
          },
          child: Container(
            margin: EdgeInsets.only(
              right: width * 0.035,
              left: width * 0.035,
              top: height * 0.015,
              bottom: height * 0.1,
            ),
            height: height * 0.06,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: const Center(
              child: Text(
                'order',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        )*/
      ],
    );
  }
}

class TableRow extends StatelessWidget {
  const TableRow({
    Key? key,
    required this.width,
    this.isTopContainer = false,
    required this.label,
    required this.text,
  }) : super(key: key);

  final double width;
  final bool isTopContainer;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * .8,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: isTopContainer
            ? const Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey),
              )
            : const Border(
                bottom: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey),
              ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width * 0.7,
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 4,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
