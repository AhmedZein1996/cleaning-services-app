import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormError extends StatelessWidget {
  const FormError({
    required this.errors,
  });

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .8,
      child: Column(
          children: List.generate(
        errors.length,
        (index) => formErrorText(error: errors[index], size: size),
      )),
    );
  }

  Column formErrorText({required String error, required Size size}) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/Error.svg",
              //color: Colors.blue,
              height: 14,
              width: 14,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(error, style: TextStyle(color: Colors.grey.shade600),),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
