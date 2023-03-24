import 'dart:developer';

import 'package:clean_services_app/components/coustom_bottom_nav_bar.dart';
import 'package:clean_services_app/model/enquriy_category.dart';
import 'package:clean_services_app/server/databases/enquries_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:clean_services_app/utilities/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'common_questions.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedCategory = '';
  bool isLoading = true;
  List<EnquiryCategory> categories = [].cast<EnquiryCategory>();

  void enquiryCategories() {
    globalClient
        .query(
      QueryOptions(
          document: gql(enquiryCategoriesQuery),
          fetchPolicy: FetchPolicy.noCache,
          variables: {"first": 10000}),
    )
        .then(
      (QueryResult result) {
        // log('Enquries : ${result.toString()}');
        categories = EnquiresHelper.enquiryCategories(result.data);
        selectedCategory = categories.first.enquiryId;
        setState(() {
          isLoading = false;
        });
      },
    ).catchError(
      (error) {
        log("$error");
      },
    );
  }

  @override
  initState() {
    enquiryCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: isLoading
            ? AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
              )
            : AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Enquires',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                elevation: 0,
                bottom: TabBar(
                  onTap: (index) {
                    setState(() {
                      selectedCategory = categories[index].enquiryId;
                    });
                  },
                  indicatorColor: Colors.transparent,
                  isScrollable: true,
                  labelColor: Colors.black,
                  tabs: categories
                      .map((category) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: selectedCategory == category.enquiryId
                                  ? kPrimaryColor
                                  : Colors.white,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.0, 1.0),
                                  color: Theme.of(context).hoverColor,
                                  blurRadius: 1,
                                )
                              ],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              category.enquiryName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: selectedCategory == category.enquiryId
                                      ? Colors.white
                                      : kPrimaryColor),
                            ),
                          ))
                      .toList(),
                ),
              ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: categories
                      .map((category) => CommonQuestions(
                            id: int.parse(category.enquiryId),
                          ))
                      .toList(),
                ),
              ),
        bottomNavigationBar:
            const CustomBottomNavBar(selectedMenu: MenuState.messages),
      ),
    );
  }
}
