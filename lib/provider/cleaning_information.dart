import 'dart:developer';

import 'package:clean_services_app/model/service.dart';
import 'package:flutter/cupertino.dart';

class CleaningInformation {
  final String? serviceId;
  final String? serviceTitle;
//  final String? servicePrice;
  final String? serviceDescription;
  final Regulation selectedRegulation;
  final String timeToServe;
  final DateTime dateOfServe;
  final String dateOfServeId;
  final String apartmentSize;

  CleaningInformation({
    required this.serviceId,
    required this.dateOfServeId,
    required this.serviceTitle,
    // required this.servicePrice,
    required this.serviceDescription,
    required this.selectedRegulation,
    required this.timeToServe,
    required this.dateOfServe,
    required this.apartmentSize,
  });
}

class CleaningInformationProvider with ChangeNotifier {
  CleaningInformation? _cleaningInfo;

  CleaningInformation? get cleaningInformation {
    return _cleaningInfo;
  }

  setCleaningInformation({required CleaningInformation cleaningInformation}) {
    _cleaningInfo = CleaningInformation(
      dateOfServeId: cleaningInformation.dateOfServeId,
      serviceId: cleaningInformation.serviceId,
      serviceTitle: cleaningInformation.serviceTitle,
      //servicePrice: cleaningInformation.servicePrice,
      serviceDescription: cleaningInformation.serviceDescription,
      selectedRegulation: cleaningInformation.selectedRegulation,
      timeToServe: cleaningInformation.timeToServe,
      dateOfServe: cleaningInformation.dateOfServe,
      apartmentSize: cleaningInformation.apartmentSize,
    );
    log('<<<<<<<<id>>>>>>>>>${_cleaningInfo!.serviceId}>>>>>>>>>');
    log('<<<<<<<<title>>>>>>>>>${_cleaningInfo!.serviceTitle}>>>>>>>>>');
    log('<<<<<<<<description>>>>>>>>>${_cleaningInfo!.serviceDescription}>>>>>>>>>');
    log('<<<<<<<<selectedRegulationTitle>>>>>>>>>${_cleaningInfo!.selectedRegulation.title}>>>>>>>>>');
    log('<<<<<<<<selectedRegulationId>>>>>>>>>${_cleaningInfo!.selectedRegulation.id}>>>>>>>>>');
    log('<<<<<<<<selectedDuration>>>>>>>>>${_cleaningInfo!.timeToServe}>>>>>>>>>');
    log('<<<<<<<<inputSize>>>>>>>>>${_cleaningInfo!.apartmentSize}>>>>>>>>>');
    log('<<<<<<<<time to serve>>>>>>>>>${_cleaningInfo!.timeToServe}>>>>>>>>>');
    log('<<<<<<<<time to serveIDD>>>>>>>>>${_cleaningInfo!.dateOfServeId}>>>>>>>>>');
    notifyListeners();
  }
}
