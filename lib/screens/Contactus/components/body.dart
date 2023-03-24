import 'dart:developer';

import 'package:clean_services_app/components/contact_us_card.dart';
import 'package:clean_services_app/model/social_information.dart';
import 'package:clean_services_app/screens/FeedbackTabs/feedback_tabs_screen.dart';
import 'package:clean_services_app/server/databases/social_info_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<SocialInfo> socialInfo = [].cast<SocialInfo>();

  bool isLoading = true;

  void sellectedPage(BuildContext context, String page) {
    Navigator.of(context).pushNamed(page);
  }

  fetchSocialInfo() {
    globalClient
        .query(QueryOptions(
            document: gql(socialQuery), fetchPolicy: FetchPolicy.noCache))
        .then((QueryResult result) {
      socialInfo = SocialInfoHelper.socialInfo(result.data);
      setState(() {
        isLoading = false;
      });
      log('data${result.data}');
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      log('error${error}');
    });
  }

  @override
  void initState() {
    fetchSocialInfo();
    super.initState();
  }

  _canLaunchUrl(String url)async{
    if (await canLaunch(url)) {
    await launch(url);
    }else {
    //    throw 'Could not launch $url';
    log('Could not launch $url');
  //  log('Could not launch $socialName');}
  }}

  _launchURL(String url, String socialName) async {
      if (socialName == 'facebook') {
        _canLaunchUrl(url);
      } else if (socialName == 'google') {
       _canLaunchUrl('mailto:$url');
      } else if (socialName == 'phone') {
       _canLaunchUrl('tel:$url');
      } else {
        //ToDo: Firebase bug
        // ToDo: read translation strings by using method in shared file
     _canLaunchUrl('whatsapp://send?phone=$url');
        //"whatsapp://send?phone=$phone";
        //   return "https://wa.me/$phone/?text=${Uri.parse(message)}";
      }
    }


  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                ...socialInfo
                    .map(
                      (social) => Padding(
                        padding:
                            const EdgeInsets.only(top: 20, right: 10, left: 10),
                        child: ContactUsCard(
                          onPressed: () {
                            _launchURL(social.value, social.name);
                          },
                          title: social.name ,
                          description:
                              'keep in touch , and let us know how we can serve you :)',
                          buttuonText: social.name == 'facebook'
                              ? 'Our facebook page'
                              : social.name == 'whatsapp'
                                  ? 'Send a whatsapp message'
                                  : social.name == 'phone'
                                      ? 'Call Us'
                                      : 'Send an email',
                        ),
                      ),
                    )
                    .toList(),
                /*Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                  child: ContactUsCard(
                      onPressed: () =>
                          sellectedPage(context, FeedbackTabsScreen.routeName),
                      title: 'Gmail',
                      description:
                          'keep in touch , and let us know how we can serve you  :)',
                      buttuonText: 'Send an email'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                  child: ContactUsCard(
                      onPressed: () =>
                          sellectedPage(context, FeedbackTabsScreen.routeName),
                      title: 'Message Us',
                      description:
                          'keep in touch , and let us know how we can serve you  :)',
                      buttuonText: 'Send a message '),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                  child: ContactUsCard(
                      onPressed: () {
                        _launchURL('');
                      },
                      title: 'Facebook',
                      description:
                          'keep in touch , and let us know how we can serve you :)',
                      buttuonText: 'Our Facebook Page'),
                ),*/
/*                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: ContactUsCard(
                      onPressed: () =>
                          sellectedPage(context, FeedbackTabsScreen.routeName),
                      title: 'Call Us',
                      description:
                          'you can also call Us on numbers displayed on Screen :)',
                      buttuonText: '+010923333333'),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: ContactUsCard(
                      onPressed: () =>
                          sellectedPage(context, FeedbackTabsScreen.routeName),
                      title: 'FeedBack',
                      description:
                          'kindly to let us know how we can improve Our app functionality :)',
                      buttuonText: 'FeedBack'),
                ),
              ],
            ),
          );
  }
}
