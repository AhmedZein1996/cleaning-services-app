import 'package:clean_services_app/provider/cleaning_information.dart';
import 'package:clean_services_app/provider/user_informatin.dart';
import 'package:clean_services_app/server/databases/orders_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OrderItem {
  final String? id;
  final String? price;
  final int statusCode;
  final String status;
  final DateTime dateTime;
  final CleaningInformation cleaningInformation;
  final UserInformationModel userInformation;

  OrderItem({
    required this.status,
    required this.statusCode,
    required this.id,
    required this.price,
    required this.dateTime,
    required this.cleaningInformation,
    required this.userInformation,
  });
}

class OrdersProvider with ChangeNotifier {
  bool isLoading = true;
  List<OrderItem> _orderItems = [];

  List<OrderItem> get orders {
    return [..._orderItems];
  }

  fetchOrder() {
    globalClient
        .query(QueryOptions(
            document: gql(ordersQuery), fetchPolicy: FetchPolicy.noCache))
        .then((QueryResult result) {
       _orderItems = OrdersHelper.orders(result.data);
      isLoading = false;
      notifyListeners();
    });
  }

  /*addOrder(
      {required CleaningInformation cleaningInformation,
      required UserInformationModel userInformation}) {
    final dateTime = DateTime.now();
    _orderItems.add(
      OrderItem(

        statusCode: 1,
        status: "",
        id: cleaningInformation.serviceId,
        price: 'null',
        dateTime: dateTime,
        cleaningInformation: cleaningInformation,
        userInformation: userInformation,
      ),
    );
    notifyListeners();
  }*/
}
