import 'package:clean_services_app/provider/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  final OrderItem orderItem;

  const OrderWidget({Key? key, required this.orderItem}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cleaningInformation = widget.orderItem.cleaningInformation;
    final userInformation = widget.orderItem.userInformation;
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
              child: ListTile(
                leading: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'total Price : ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: '\$${widget.orderItem.price}',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ],
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    DateFormat('dd/MM/yy  hh:mm')
                        .format(widget.orderItem.dateTime),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
            ),
            if (_expanded)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Name : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${userInformation.firstName} ${userInformation.lastName}',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'email : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: ' ${userInformation.email}',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'identityNumber : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: ' ${userInformation.identityNumber}',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Title : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: '${cleaningInformation.serviceTitle}',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Duration : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${cleaningInformation.timeToServe} hours',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
					  Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Date of serve : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${cleaningInformation.dateOfServe.toString().split('.').first}',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Description : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${cleaningInformation.serviceDescription} ',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Regulation : ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${cleaningInformation.selectedRegulation.title} ',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
