import 'package:clean_services_app/components/text_field_container.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hint;
  final validator;
  final FormFieldSetter<String> onSaved;

  RoundedPasswordField({
    Key? key,
    required this.validator,
    required this.onSaved,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: widget.validator,
        obscureText: hidePassword,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade800,
          ),
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.visibility),
            color: kPrimaryColor,
            onPressed: () => setState(() {
              hidePassword = !hidePassword;
            }),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
