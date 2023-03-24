import 'dart:developer';

import 'package:flutter/cupertino.dart';

class UserInformationModel {
  String streetAddress;
  String postCode;
  String firstName;
  String lastName;
  String email = '';
  String phone;
  String identityNumber;
  bool isHaveCats;
  bool isHaveDogs;
  bool isHaveOtherPets;

  UserInformationModel({
    this.streetAddress = '',
    this.postCode = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.identityNumber = '',
    this.isHaveCats = false,
    this.isHaveDogs = false,
    this.isHaveOtherPets = false,
  });
}

class UserInformationProvider with ChangeNotifier {
  UserInformationModel _userInfo = UserInformationModel();

  UserInformationModel get userInformation {
    return _userInfo;
  }

  setUserInformation({required UserInformationModel userInformation}) {
    _userInfo = UserInformationModel(
      streetAddress: userInformation.streetAddress,
      postCode: userInformation.postCode,
      firstName: userInformation.firstName,
      lastName: userInformation.lastName,
      email: userInformation.email,
      phone: userInformation.phone,
      identityNumber: userInformation.identityNumber,
      isHaveCats: userInformation.isHaveCats,
      isHaveDogs: userInformation.isHaveDogs,
      isHaveOtherPets: userInformation.isHaveOtherPets,
    );
    log('<<<<<<<<firstName>>>>>>>>>${_userInfo.firstName}>>>>>>>>>');
    log('<<<<<<<<streetAddress>>>>>>>>>${_userInfo.streetAddress}>>>>>>>>>');
    log('<<<<<<<<postCode>>>>>>>>>${_userInfo.postCode}>>>>>>>>>');
    log('<<<<<<<<email>>>>>>>>>${_userInfo.email}>>>>>>>>>');
    log('<<<<<<<<phone>>>>>>>>>${_userInfo.phone}>>>>>>>>>');
    log('<<<<<<<<identity number>>>>>>>>>${_userInfo.identityNumber}>>>>>>>>>');
    log('<<<<<<<<isHaveCats>>>>>>>>>${_userInfo.isHaveCats}>>>>>>>>>');
    log('<<<<<<<<isHaveDogs>>>>>>>>>${_userInfo.isHaveDogs}>>>>>>>>>');
    log('<<<<<<<<isHaveOtherPets>>>>>>>>>${_userInfo.isHaveOtherPets}>>>>>>>>>');
    notifyListeners();
  }
}
