import 'dart:developer';

import 'package:clean_services_app/model/enquiry.dart';
import 'package:clean_services_app/model/enquriy_category.dart';

class EnquiresHelper {
  static List<EnquiryCategory> allCategories = [].cast<EnquiryCategory>();

  static enquiryCategories(Map<String, dynamic>? data) {
    allCategories = (data!['enquiryCategories']["data"] as List<dynamic>)
        .map((element) => EnquiryCategory(
            enquiryId: element['id'], enquiryName: element['name']))
        .toList();
    log("name----->>>>>>>> ${allCategories[1].enquiryName}");
    return allCategories;
  }

  static enquiryCategory(Map<String, dynamic>? data) {
    if ((data!['enquiryCategory']["enquiries"]["data"] as List<dynamic>)
        .isEmpty) {
      return;
    }
    final List<Enquiry> fetchedCategoryEnquires =
        (data['enquiryCategory']["enquiries"]["data"] as List<dynamic>)
            .map(
              (enquiry) => Enquiry(
                header: enquiry['question'],
                body: enquiry['answer'],
              ),
            )
            .toList();
    log("name----->>>>>>>> ${fetchedCategoryEnquires[0].header}");
    return fetchedCategoryEnquires;
  }
}
