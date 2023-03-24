import 'package:clean_services_app/components/text_field_container.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:flutter/material.dart';



class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FormFieldSetter<String> onSaved;
  final validator;
  const RoundedInputField(
      {required this.validator,
      required this.hintText,
      this.icon = Icons.person,
      required this.onChanged,
      required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        style:  const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0),
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(

              color: Colors.grey.shade800,
          ),

          border: InputBorder.none,
        ),
      ),
    );
  }
}
