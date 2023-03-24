class Regulation {
  String id;
  String title;
  int pricePerHour;
  int pricePerHourWithoutRut;
  bool isMostPopular;
  List<dynamic>? availableDates;
  List<dynamic>? availableDatesWithId;

  Regulation({
    required this.id,
    required this.isMostPopular,
    required this.title,
    required this.pricePerHour,
    required this.pricePerHourWithoutRut,
    this.availableDates,
    this.availableDatesWithId,
  });
}

class ServiceDuration {
  String id;
  int from;
  int to;
  int minimumHours;

  ServiceDuration({
    required this.id,
    required this.from,
    required this.to,
    required this.minimumHours,
  });
}

class ServiceModel {
  final String serviceId;
  final String serviceTitle;
  final String serviceDescription;
  final String serviceImageUrl;
  final List<Regulation> regulations;

  ServiceModel({
    required this.serviceId,
    required this.serviceImageUrl,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.regulations,
  });
}
