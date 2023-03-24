import 'dart:developer';

import 'package:clean_services_app/model/service.dart';

class ServiceHelper {
  // static List<ServiceModel> _services = [];

  static List<ServiceModel> _loadedServices = [].cast<ServiceModel>();

  static getServices(Map<String, dynamic>? data) {
    _loadedServices = [].cast<ServiceModel>();
    final fetchedData = data!['services'];
//    final List _loadedServices = [].cast<ServiceModel>();
    //log("$data");
    fetchedData.forEach((service) {
      _loadedServices.add(
        ServiceModel(
            serviceImageUrl: service['image_url'],
            serviceTitle: service['title'],
            serviceId: service['id'],
            serviceDescription: service['description'],
            regulations: (service['regulations'] as List<dynamic>)
                .map((regulation) => Regulation(
                      id: regulation['id'],
                      title: regulation['title'],
                      pricePerHour: regulation['price_per_hour'],
                      pricePerHourWithoutRut:
                          regulation['price_per_hour_without_RUT'],
                      isMostPopular: regulation['is_most_popular'],
                      availableDates: regulation['availableDatesAsArray'],
                      availableDatesWithId: regulation['availableDates'],
                    ))
                .toList()),
      );
    });
    return _loadedServices;
  }

  static availableDaysByRegulationId(
      {required String regulationId, required String serviceId}) {
    ServiceModel service =
        _loadedServices.firstWhere((service) => service.serviceId == serviceId);

    List<dynamic>? availableDays = service.regulations
        .firstWhere((regulation) => (regulation.id == regulationId))
        .availableDates;
    List<dynamic>? availableDaysWithId = service.regulations
        .firstWhere((regulation) => (regulation.id == regulationId))
        .availableDatesWithId;
    log('avalible days from availableDaysByRegulationId${availableDays!.length}');

    return [availableDays, availableDaysWithId];
  }

//  static addSelectedService(ServiceModel service) {
//    json.encode(
//      {
//        'image_url': service.serviceImageUrl,
//        'title': service.serviceTitle,
//        'id': service.serviceId,
//        'description': service.serviceDescription,
//      },
//    );
//  }
}

/*static fromJSON( Map<String, Map<String, Map<String, List<Map<String, String>>>>> data) {
   final List loadedServices = data["services"]?["data"] as List;
   print(loadedServices.length);

    // loadedServices = data["services"]["data"];
    // title = data["services"]["data"][0]["title"];
  }*/
