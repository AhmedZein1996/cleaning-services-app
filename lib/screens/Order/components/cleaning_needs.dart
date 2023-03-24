import 'dart:developer';

import 'package:clean_services_app/model/service.dart';
import 'package:clean_services_app/provider/cleaning_information.dart';
import 'package:clean_services_app/screens/Contactus/contactus_screen.dart';
import 'package:clean_services_app/server/databases/durations_helper.dart';
import 'package:clean_services_app/server/databases/sevices_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../../components/cleaning_needs_container.dart';

enum Selected {
  oneTime,
  everyWeek,
  everySecondWeek,
  everyDay,
}

class CleaningNeeds extends StatefulWidget {
  List<Regulation> regulations = [].cast<Regulation>();
  final String? serviceId;
  final String? serviceTitle;
  final String? serviceDescription;
  final Function continueToNextPage;

  CleaningNeeds({
    Key? key,
    required this.regulations,
    required this.serviceId,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.continueToNextPage,
  }) : super(key: key);

  @override
  CleaningNeedsState createState() => CleaningNeedsState();
}

class CleaningNeedsState extends State<CleaningNeeds> {
  String exeption = '';
  bool isOfferFound = true;
  String size = '';
  int? dataCount;
  String selectContainer = '';
  dynamic offers;
  String error = '';
  List<double>? durationList;
  int? minimumHours;
  String selectedDuration = 'Choose your duration';
  String selectedDate = 'Choose when you a want to clean';
  String selectedDateId = '';
  List<dynamic>? availableDaysArray = [];
  List<dynamic>? availableDaysWithIdArray = [];

  //Selected? selectedContainer;

  @override
  void initState() {
    super.initState();
  }

  void checkRequiredCleaningInfo() {
    if (selectContainer.isEmpty ||
        size.isEmpty ||
        selectedDuration == 'Choose your duration' ||
        selectedDate == 'Choose when you a want to clean') {
      widget.continueToNextPage(false);
    } else {
      Regulation selectedRegulation = widget.regulations
          .firstWhere((regulation) => regulation.id == selectContainer);
      log("${selectedRegulation.id}||||||||||||||||${selectedRegulation.title}");
      selectedDateId = availableDaysWithIdArray?.firstWhere(
          (availabledates) => availabledates["date"] == selectedDate)["id"];
      log("messageeeeeeeeeeeeeeeeeee : id $selectedDateId");
      Provider.of<CleaningInformationProvider>(context, listen: false)
          .setCleaningInformation(
              cleaningInformation: CleaningInformation(
                  serviceId: widget.serviceId,
                  serviceTitle: widget.serviceTitle,
                  //servicePrice: widget.servicePrice,
                  serviceDescription: widget.serviceDescription,
                  selectedRegulation: selectedRegulation,
                  timeToServe: selectedDuration,
                  dateOfServe: DateTime.parse(selectedDate),
                  dateOfServeId: selectedDateId,
                  apartmentSize: size));
      widget.continueToNextPage(true);
    }
  }

  void getAvailableDaysArray({
    required String regulationId,
    required String serviceId,
  }) {
    final List<dynamic>? availableDays =
        ServiceHelper.availableDaysByRegulationId(
            regulationId: regulationId, serviceId: serviceId)[0];
    final List<dynamic>? availableDaysWithId =
        ServiceHelper.availableDaysByRegulationId(
            regulationId: regulationId, serviceId: serviceId)[1];
    //log('avalible days from getAvailableDaysArray${availableDays!.length}');
    if (availableDays != null && availableDays.isNotEmpty) {
      availableDaysArray = availableDays;
      availableDaysWithIdArray = availableDaysWithId;
    } else {
      availableDaysArray = null;
    }
  }

  void getDurations({required String serviceId, required String regulationId}) {
    globalClient
        .query(
      QueryOptions(
        document: gql(durationQuery),
        variables: {
          "service_id": serviceId,
          "regulation_id": regulationId,
        },
      ),
    )
        .then((QueryResult result) {
      log('duration : ${result.data.toString()}');
      ServiceDuration duration = DurationsHelper.durations(result.data);
      log('minimum_hours : ${duration.minimumHours}');
      setState(() {
        if (size.isNotEmpty) {
          try {
            durationList =
                DurationsHelper.durationBySize(size: int.parse(size));

            exeption = '';
//            widget.continueToNextPage(selectContainer, size, selectedDuration);
          } catch (e) {
            exeption = e.toString();
            log(e.toString());
            durationList = null;
          }
        }
      });

      if (_formKey.currentState!.validate()) {}
    }).catchError(
      (error) {
        log("$error");
      },
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    dataCount = widget.regulations.length;
    offers = List.generate(dataCount!, (index) {
      return CleaningNeedsContainer(
        width: selectContainer == widget.regulations[index].id ? 3 : 1,
        color: selectContainer == widget.regulations[index].id
            ? Colors.blue
            : Colors.grey,
        onPress: () {
          setState(() {
            selectContainer = widget.regulations[index].id;
            selectedDuration = 'Choose your duration';
            selectedDate = 'Choose when you a want to clean';
          });
          log('hhhhhhhhhhhhhhhhhhddddddd');
          getAvailableDaysArray(
              regulationId: selectContainer, serviceId: widget.serviceId!);
          getDurations(
              regulationId: selectContainer, serviceId: widget.serviceId!);
        },
        priceWithDeduction: widget.regulations[index].pricePerHour.toString(),
        priceWithoutDeduction:
            widget.regulations[index].pricePerHourWithoutRut.toString(),
        isMostPopular: widget.regulations[index].isMostPopular,
        offerTitle: widget.regulations[index].title,
      );
    });
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 15, left: 15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
              child: Text(
                'APPERENT SIZE',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            TextFormField(
              validator: (value) {
                if (exeption.isNotEmpty) {
                  log(exeption);
                  if (exeption == 'Bad state: No element') {
                    return 'oops there is no cleaning service for such an area';
                  } else {
                    return exeption;
                  }
                }
                return null;
              },
              onChanged: (newValue) {
                if (newValue.isEmpty) {
                  return;
                }

                size = newValue;
//              durationList =
//                  CleaningServices.durationBySize(size: int.parse(newValue));
                if (selectContainer.isEmpty) {
                  return;
                }
                try {
                  getDurations(
                      regulationId: selectContainer,
                      serviceId: widget.serviceId!);
                  setState(() {
                    exeption = '';
                  });
//
                } catch (e) {
                  setState(() {
                    exeption = e.toString();
                    log(e.toString());
                    durationList = null;
                  });
                }
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                errorMaxLines: 3,
                suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'm\u{00B2}',
                      style: TextStyle(color: Colors.grey),
                    )),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            if (durationList != null)
              DropdownButton<double>(
                hint: Text(selectedDuration),
                items: durationList!.map((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue.toString().isEmpty) {
                    return;
                  }

                  setState(() {
                    selectedDuration = newValue.toString();
                  });
                },
              ),
            SizedBox(
              height: height * 0.025,
            ),
            availableDaysArray != null
                ? Column(
                    children: [
                      const Center(
                          child: Text(
                        ' WHEN CAN WE CLEAN?',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      DropdownButton<dynamic>(
                          hint: Text(selectedDate),
                          items: availableDaysArray!.map((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue.toString().isEmpty) {
                              return;
                            }
                            setState(() {
                              selectedDate = newValue;
                            });
                          }),
                      SizedBox(
                        height: height * 0.025,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const Center(
                          child: Text(
                        'Oops, there is now available dates for now , please contact us to choose next available days or you can choose another regulation',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.redAccent),
                      )),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      TextButton(
                        style: Theme.of(context).textButtonTheme.style,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ContactUsScreen.routeName);
                        },
                        child: Text("Contact Us "),
                      ),
                    ],
                  ),
            SizedBox(
              height: height * 0.015,
            ),
            const Center(
                child: Text(
              ' HOW OFTEN SHOULD WE CLEAN?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: height * 0.015,
            ),
            Column(
              children: offers,
            ),
          ],
        ),
      ),
    );
  }
}

/* Container(
              margin: EdgeInsets.only(
                right: width * 0.035,
                left: width * 0.035,
                top: height * 0.015,
                bottom: height * 0.1,
              ),
              height: height * 0.06,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )*/

/***********************************/

//            DropdownButton<String>(
//              hint: const Text('Choose your duration'),
//              items:
////              [
////                DropdownMenuItem<String>(
////                  value: durationValue ?? '',
////                  child: Text(durationValue ?? '',),
////                ),
////              ]
//
//              onChanged: (_) {},
//            ),
//        DropdownButton<String>(
//          hint: const Text('Choose your duration'),
//          items: <String>['2 hours', '3 hours', '4 hours', '5 hours']
//              .map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text(value),
//            );
//          }).toList(),
//          onChanged: (_) {},
//        ),
