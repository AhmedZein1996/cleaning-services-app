import 'dart:developer';

import 'package:clean_services_app/model/service.dart';
import 'package:clean_services_app/screens/Order/components/cleaning_needs.dart';
import 'package:clean_services_app/screens/Order/components/personal_information.dart';
import 'package:clean_services_app/screens/Payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'order_information.dart';

final GlobalKey<PersonalInformationState>? personalInformationGlobalKey =
    GlobalKey();
final GlobalKey<CleaningNeedsState>? cleaningNeedsGlobalKey = GlobalKey();

class Body extends StatefulWidget {
  String? serviceId;
  String? serviceTitle;
  String? serviceDescription;
  List<Regulation> regulations = [].cast<Regulation>();

  Body({
    Key? key,
    required this.serviceId,
    required this.regulations,
    required this.serviceTitle,
    required this.serviceDescription,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _stepIndex = 0;
  bool _isAllowedToContinue = false;

//  _gotoDatePage(isVaild) {
//    if (!selectContainer.isNotEmpty &&
//        !size.isNotEmpty &&
//        selectedDuration != 'Choose your duration') {
//      _isAllowedToContinue = false;
//    } else {
//      _isAllowedToContinue = true;
//    }
//  }

  _gotoNextPage(isValid) {
    if (isValid) {
      _isAllowedToContinue = true;
    } else {
      _isAllowedToContinue = false;
    }
  }

  List<Step> getSteps() => [
        Step(
          state: _stepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _stepIndex == 0 ? true : false,
          title: const Text(
            'cleaning ',
          ),
          subtitle: Text(
            'information',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          content: CleaningNeeds(
            regulations: widget.regulations,
            serviceId: widget.serviceId,
            serviceTitle: widget.serviceTitle,
            serviceDescription: widget.serviceDescription,
            key: cleaningNeedsGlobalKey,
            continueToNextPage: _gotoNextPage,
          ),
        ),
        Step(
          state: _stepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _stepIndex == 1 ? true : false,
          title: const Text(
            'user',
          ),
          subtitle: Text(
            'information',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          content: PersonalInformation(
            key: personalInformationGlobalKey,
            continueToNextPage: _gotoNextPage,
          ),
        ),
        Step(
          state: _stepIndex <= 2 ? StepState.editing : StepState.complete,
          isActive: _stepIndex == 2 ? true : false,
          title: const Text(
            'Order',
          ),
          subtitle: Text(
            'information',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          content: OrderInformation(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: getSteps(),
      type: StepperType.horizontal,
      currentStep: _stepIndex,
      onStepContinue: () {
        log('isAllowedToContinue: $_isAllowedToContinue');
        /*     if (_stepIndex < getSteps().length - 1) {
          if (_isAllowedToContinue) {
            setState(() {
              _stepIndex++;
            });
            _isAllowedToContinue = false;
          }
        }*/
        if (_stepIndex < getSteps().length - 1 && _stepIndex == 0) {
          cleaningNeedsGlobalKey?.currentState!.checkRequiredCleaningInfo();
          if (_isAllowedToContinue) {
            setState(() {
              _stepIndex++;
            });
            _isAllowedToContinue = false;
          } else {
            Fluttertoast.showToast(
                msg: "you must enter all required data",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          // show Toast
        } else if (_stepIndex < getSteps().length - 1 && _stepIndex == 1) {
          //final personalInformation = PersonalInformation.globalKey?.currentState;
          //final Function? saveForm = !.saveForm();
//          final _saveForm = personalInformationGlobalKey?.currentState?.saveForm;
//          if (_saveForm == null) {
//            log('save form is null');
//            return;
//          }
//          log('form is saved');
//          _saveForm();
          personalInformationGlobalKey?.currentState!.saveForm();
          if (_isAllowedToContinue) {
            setState(() {
              _stepIndex++;
            });
            _isAllowedToContinue = false;
          }
        }
        // this else will be executed when _stepIndex == 2 then stepper will be navigate to the payment page
        else {
          Navigator.of(context).pushNamed(PaymentScreen.routeName);
        }
      },
      onStepCancel: () {
        if (_stepIndex > 0) {
          setState(() {
            _stepIndex--;
          });
        }
      },
    );
  }
}
//log("you must enter all required data");
