
import 'package:clean_services_app/model/service.dart';

class DurationsHelper {
  static List<ServiceDuration> allDurations = [];

  static durations(Map<String, dynamic>? data) {
    // final fetchedDurations = data!['durationsQueries'];
    allDurations = (data!['durationsQueries'] as List<dynamic>)
        .map((element) => ServiceDuration(
              id: element['id'],
              from: element['from'],
              to: element['to'],
              minimumHours: element['minimum_hours'],
            ))
        .toList();
    return allDurations[0];
  }

  static durationBySize({required int size}) {
    ServiceDuration duration = allDurations.firstWhere(
        (duration) => (size >= duration.from && size <= duration.to),
        orElse: () {

      ServiceDuration duration =
          allDurations.firstWhere((duration) => (size <= duration.from));
      throw Exception(
          "There is no  duration for this,min size is ${duration.from} m\u{00B2}");
    });
    // log("this is LLList -------->  ${allDurations}");
    /*if (duration.minimumHours == null) {
      throw Exception("There is no  duration for this area");
    }*/
    return generateDurationList(duration.minimumHours);
  }

  /*static durationBySize({required int size}) {
    ServiceDuration duration =
        allDurations.firstWhere((duration) => size <= duration.to);
    log("this is LLList -------->  ${allDurations.length}");
    return generateDurationList(duration.minimumHours);
  }*/

  static generateDurationList(int minimumHour) {
    final List<double> durationList = [];
    double minHour = minimumHour.toDouble();
    while (minHour <= 7) {
      durationList.add(minHour);
      minHour += .5;
    }
    return durationList;
  }
}
