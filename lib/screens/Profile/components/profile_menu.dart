
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Theme.of(context).textTheme.button!.color,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyText1,
            ),),
              Icon(Icons.arrow_forward_ios, color: Theme.of(context).textTheme.bodyText1!.color,),
          ],
        ),
      ),
    );
  }
}
