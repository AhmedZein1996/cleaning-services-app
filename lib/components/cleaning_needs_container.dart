// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CleaningNeedsContainer extends StatelessWidget {
  final double width;
  final bool isMostPopular;
  final String offerTitle;
  final Color color;
  final Function onPress;
  final String priceWithoutDeduction;
  final String priceWithDeduction;

  CleaningNeedsContainer({
    required this.offerTitle,
    required this.priceWithoutDeduction,
    required this.priceWithDeduction,
    required this.width,
    required this.color,
    this.isMostPopular = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(children: [
      GestureDetector(
        onTap: () => onPress(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offerTitle,
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      Text(
                        '$priceWithoutDeduction /h',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'without deduction',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  Text(
                    '$priceWithDeduction /h',
                    style: TextStyle(color: Colors.blue, fontSize: 22),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: width,
                    color: color,
                  ),
                  borderRadius: BorderRadius.circular(8)),
            ),
            SizedBox(
              height: height * 0.015,
            ),
          ],
        ), // احتمال يعطيني ايرور Error
      ),
      if (isMostPopular == true)
        Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )),
              child: Text(
                'Most popular',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ))
    ]);
  }
}
