import 'dart:developer';

import 'package:clean_services_app/components/input_information_field.dart';
import 'package:clean_services_app/provider/user_informatin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/enums.dart';

class PersonalInformation extends StatefulWidget {
  final Function continueToNextPage;

  const PersonalInformation({Key? key, required this.continueToNextPage})
      : super(key: key);

  @override
  State<PersonalInformation> createState() => PersonalInformationState();
}

class PersonalInformationState extends State<PersonalInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _checkBoxParentValue = false;
  bool _checkBoxCatsValue = false;
  bool _checkBoxDogsValue = false;
  bool _checkBoxOtherValue = false;

  var _userInformation = UserInformationModel(
    streetAddress: '',
    postCode: '',
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    identityNumber: '',
    isHaveCats: false,
    isHaveDogs: false,
    isHaveOtherPets: false,
  );

  saveForm() {
    final isValid = _formKey.currentState!.validate();
    log('isvaild: $isValid');
    if (!isValid) {
      widget.continueToNextPage(false);
    } else {
      _formKey.currentState!.save();
      Provider.of<UserInformationProvider>(context, listen: false)
          .setUserInformation(userInformation: _userInformation);
      widget.continueToNextPage(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 15, left: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.025,
                ),
                const Center(
                    child: Text(
                  'Need some info about place',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: height * 0.025,
                ),
                InputInformationField(
                  type: KeyboardType.text,
                  label: 'Street adress and number',
                  onSaved: (value) {
                    _userInformation = UserInformationModel(
                      streetAddress: value,
                      postCode: _userInformation.postCode,
                      firstName: _userInformation.firstName,
                      lastName: _userInformation.lastName,
                      email: _userInformation.email,
                      phone: _userInformation.phone,
                      identityNumber: _userInformation.identityNumber,
                      isHaveCats: _checkBoxCatsValue,
                      isHaveDogs: _checkBoxDogsValue,
                      isHaveOtherPets: _checkBoxOtherValue,
                    );
                  },
                ),
                SizedBox(
                  height: height * .025,
                ),
                InputInformationField(
                  type: KeyboardType.numbers,
                  label: 'Postcode',
                  onSaved: (value) {
                    _userInformation = UserInformationModel(
                      streetAddress: _userInformation.streetAddress,
                      postCode: value,
                      firstName: _userInformation.firstName,
                      lastName: _userInformation.lastName,
                      email: _userInformation.email,
                      phone: _userInformation.phone,
                      identityNumber: _userInformation.identityNumber,
                      isHaveCats: _checkBoxCatsValue,
                      isHaveDogs: _checkBoxDogsValue,
                      isHaveOtherPets: _checkBoxOtherValue,
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  padding: const EdgeInsets.all(3.0),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _checkBoxParentValue,
                            onChanged: (newValue) {
                              setState(() {
                                _checkBoxParentValue = newValue!;
                              });
                            },
                          ),
                          const Text(
                            'pets live here',
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                        ],
                      ),
                      if (_checkBoxParentValue)
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'What kind? let\'s pick you a cleaner without alleeries.',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _checkBoxCatsValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _checkBoxCatsValue = newValue!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Cats',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _checkBoxDogsValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _checkBoxDogsValue = newValue!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Dogs',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _checkBoxOtherValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _checkBoxOtherValue = newValue!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Other pets',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                const Center(
                    child: Text(
                  'When can we clean?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: height * 0.025,
                ),
                const Text('No lock in contract - no commitment'),
                SizedBox(
                  height: height * 0.025,
                ),
                const Center(
                    child: Text(
                  'Almost there...',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: height * 0.025,
                ),
                InputInformationField(
                  type: KeyboardType.text,
                  label: 'First name',
                  onSaved: (value) {
                    _userInformation = UserInformationModel(
                      streetAddress: _userInformation.streetAddress,
                      postCode: _userInformation.postCode,
                      firstName: value,
                      lastName: _userInformation.lastName,
                      email: _userInformation.email,
                      phone: _userInformation.phone,
                      identityNumber: _userInformation.identityNumber,
                      isHaveCats: _checkBoxCatsValue,
                      isHaveDogs: _checkBoxDogsValue,
                      isHaveOtherPets: _checkBoxOtherValue,
                    );
                  },
                ),
                SizedBox(
                  height: height * .025,
                ),
                InputInformationField(
                  type: KeyboardType.text,
                  label: 'Last name',
                  onSaved: (value) {
                    _userInformation = UserInformationModel(
                      streetAddress: _userInformation.streetAddress,
                      postCode: _userInformation.postCode,
                      firstName: _userInformation.firstName,
                      lastName: value,
                      email: _userInformation.email,
                      phone: _userInformation.phone,
                      identityNumber: _userInformation.identityNumber,
                      isHaveCats: _checkBoxCatsValue,
                      isHaveDogs: _checkBoxDogsValue,
                      isHaveOtherPets: _checkBoxOtherValue,
                    );
                  },
                ),
                SizedBox(
                  height: height * .025,
                ),
                InputInformationField(
                  type: KeyboardType.email,
                  label: 'Email',
                  onSaved: (value) {
                    _userInformation = UserInformationModel(
                      streetAddress: _userInformation.streetAddress,
                      postCode: _userInformation.postCode,
                      firstName: _userInformation.firstName,
                      lastName: _userInformation.lastName,
                      email: value,
                      phone: _userInformation.phone,
                      identityNumber: _userInformation.identityNumber,
                      isHaveCats: _checkBoxCatsValue,
                      isHaveDogs: _checkBoxDogsValue,
                      isHaveOtherPets: _checkBoxOtherValue,
                    );
                  },
                ),
                SizedBox(
                  height: height * .025,
                ),
                InputInformationField(
                  type: KeyboardType.numbers,
                  label: 'Phone',
                  onSaved: (value) {
                    _userInformation = UserInformationModel(
                      streetAddress: _userInformation.streetAddress,
                      postCode: _userInformation.postCode,
                      firstName: _userInformation.firstName,
                      lastName: _userInformation.lastName,
                      email: _userInformation.email,
                      phone: value,
                      identityNumber: _userInformation.identityNumber,
                      isHaveCats: _checkBoxCatsValue,
                      isHaveDogs: _checkBoxDogsValue,
                      isHaveOtherPets: _checkBoxOtherValue,
                    );
                  },
                ),
                SizedBox(
                  height: height * .025,
                ),
                InputInformationField(
                  type: KeyboardType.numbers,
                  label: 'Personal identity number ',
                  onSaved: (value) {
                    _userInformation = UserInformationModel(
                      streetAddress: _userInformation.streetAddress,
                      postCode: _userInformation.postCode,
                      firstName: _userInformation.firstName,
                      lastName: _userInformation.lastName,
                      email: _userInformation.email,
                      phone: _userInformation.phone,
                      identityNumber: value,
                      isHaveCats: _checkBoxCatsValue,
                      isHaveDogs: _checkBoxDogsValue,
                      isHaveOtherPets: _checkBoxOtherValue,
                    );
                  },
                ),
                SizedBox(
                  height: height * .025,
                ),
                /* GestureDetector(
                  onTap: (){
                    saveForm();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: width * 0.035,
                      left: width * 0.035,
                      top: height * 0.015,
                      bottom: height * 0.1,
                    ),
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*
 Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(

              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                  right: BorderSide(color: Colors.grey),
                  left: BorderSide(color: Colors.grey),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First name',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Ahmed',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'last name',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'zein',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
*/
