import 'dart:developer';

import 'package:clean_services_app/model/service.dart';
import 'package:clean_services_app/provider/cleaning_information.dart';
import 'package:clean_services_app/provider/orders.dart';
import 'package:clean_services_app/provider/user_informatin.dart';

class OrdersHelper {
  static List<OrderItem> orders(Map<String, dynamic>? data) {
    List<OrderItem> loodedOrders = [].cast<OrderItem>();

    /*final List<OrderItem> orders = (data!["me"]["orders"] as List<dynamic>)*/

    (data!["me"]["orders"] as List<dynamic>).map((order) {
      if (order['payment']['status_code'] != 100) {
        loodedOrders.add(
          OrderItem(
            status: order['payment']['status'],
            statusCode: order['payment']['status_code'],
            id: order['id'],
            price: order['payment']['price_after_discount'].toString(),
            dateTime: DateTime.parse(order['created_at']),
            cleaningInformation: CleaningInformation(
              dateOfServeId: "1",
              serviceId: order['service']['id'],
              serviceTitle: order['service']['id'],
              serviceDescription: order['service']['description'],
              timeToServe: order['time_to_serve'].toString(),
              dateOfServe: DateTime.parse(order['date_of_serve']),
              apartmentSize: order['apartment_size'].toString(),
              selectedRegulation: Regulation(
                id: order['regulation']['id'],
                isMostPopular: order['regulation']['is_most_popular'],
                title: order['regulation']['title'],
                pricePerHour: order['regulation']['price_per_hour'],
                pricePerHourWithoutRut: order['regulation']
                    ['price_per_hour_without_RUT'],
              ),
            ),
            userInformation: UserInformationModel(
              streetAddress: order['location']['street_info'],
              postCode: order['location']['postcode'],
              firstName: order['buyer']['first_name'],
              lastName: order['buyer']['last_name'],
              email: order['buyer']['email'],
              phone: order['buyer']['phone'],
              identityNumber: order['buyer']['PID'],
            ),
          ),
        );
      }
    }).toList();

    //  fetchedOrders = orders.where((order) => order.statusCode != 100).toList();
    log('<<<<<<<<<<<<<from orders helper: ${loodedOrders.length}>>>>>>>>>>>>>>');
    return loodedOrders;
  }
}
