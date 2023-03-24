import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              child: const Center(
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              color: Colors.blue,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
