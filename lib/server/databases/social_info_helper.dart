import 'package:clean_services_app/model/social_information.dart';

class SocialInfoHelper {
  static socialInfo(Map<String, dynamic>? data) {
    final List<SocialInfo> _loadedSocialInfo =
        (data!["socialInfos"] as List<dynamic>)
            .map((social) => SocialInfo(
                  name: social["name"],
                  value: social["value"],
                ))
            .toList();
/*    _loadedSocialInfo.add(
      SocialInfo(
        name: 'Call Us',
        value: _loadedSocialInfo
            .firstWhere((element) => element.name == 'whatsapp').value,
      ),
    );*/
    return _loadedSocialInfo;
  }
}
