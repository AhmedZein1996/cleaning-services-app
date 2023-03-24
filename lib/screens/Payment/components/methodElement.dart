import 'package:flutter/material.dart';

class MethodElement extends StatelessWidget {
  final String assetLink;
  final String methodName;
  final Function onPress;

  MethodElement(
      {required this.assetLink,
      required this.methodName,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onPress(),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.19,
                  child: Image.asset(assetLink),
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                Text(
                  methodName,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
