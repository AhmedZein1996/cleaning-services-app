import 'package:clean_services_app/utilities/constants.dart';
import 'package:clean_services_app/utilities/regexp_validation.dart';
import 'package:flutter/material.dart';

import '../utilities/enums.dart';

class InputInformationField extends StatelessWidget {
  final String label;
  final KeyboardType type;
  final Function(String)? onSaved;

  const InputInformationField({
    Key? key,
    required this.label,
    required this.type,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: label == 'Email'
          ? (newValue) {
              if (newValue!.isEmpty) {
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(newValue)) {
                return kInvalidEmailError;
              }
              return null;
            }
          : (newValue) {
              if (newValue!.isEmpty) {
                return 'Please provide some input.';
              }
              return null;
            },
//      onChanged: (newValue) {
//              if(onChanged == null){
//                return;
//              }
//              onChanged!();
//            },
      onSaved: (value) {
        onSaved!(value!);
      },

      keyboardType: inputType(type),

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
    );
  }
}
