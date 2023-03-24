import 'package:clean_services_app/provider/app_theme.dart';
import 'package:clean_services_app/provider/local_lang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
      child: ListView(
        children: [
          const Text(
            "Settings",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: const [
              Icon(
                Icons.person,
                color: Colors.green,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          // LanguageOption(context, "Social"),
          // LanguageOption(context, "Privacy and security"),
          const LanguageOption(),
          const SizedBox(
            height: 40,
          ),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          const DarkModeSwitch(),
        ],
      ),
    );
  }
}

class LanguageOption extends StatefulWidget {
  const LanguageOption({Key? key}) : super(key: key);

  @override
  State<LanguageOption> createState() => _LanguageOptionState();
}

class _LanguageOptionState extends State<LanguageOption> {
  String selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: true);
    selectedLang = language.localLanguage;
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Language',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 18,
                    )),
//            const Icon(
//              Icons.arrow_forward_ios,
//              color: Colors.grey,
//            ),
            DropdownButton<String>(
              value: selectedLang,
              items: [
                DropdownMenuItem<String>(
                  value: 'en',
                  child: Text(
                    'English',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                DropdownMenuItem(
                  value: 'sv',
                  child: Text(
                    'Swedich',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
              onChanged: (newValue) {
                /* setState(() {
                  selectedLang = newValue!;
                  log('selectedLang:$selectedLang');
                });*/
                language.changeLanguage(fromSetting: newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool isActive = false;
  // dynamic cachedThemeMode;
/*
  @override
  void initState() {
    cachedThemeMode = CachedHelper.getThemeMode();
    if (cachedThemeMode == notFoundError) {
      isActive = false;
    } else {
      isActive = cachedThemeMode;
    }
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<AppTheme>(context, listen: true);
    isActive = themeMode.isDark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dark Mode',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 18,
              ),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: isActive,
            onChanged: (bool newValue) {
//              setState(() {
//                isActive = newValue;
//              });
              themeMode.themeToggle();
            },
          ),
        ),
      ],
    );
  }
}
// isActive = themeMode.isDark ممكن استخدم دي بدل
// setState(() {
//   isActive = newValue;
// });
// واعمل listen : true
