import 'dart:developer';

import 'package:clean_services_app/model/enquiry.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../server/databases/enquries_helper.dart';

class CommonQuestions extends StatefulWidget {
  final int id;
  const CommonQuestions({Key? key, required this.id}) : super(key: key);
  @override
  _CommonQuestionsState createState() => _CommonQuestionsState();
}

class _CommonQuestionsState extends State<CommonQuestions> {
  bool isLoading = true;
  List<Enquiry> categoryEnquiries = [].cast<Enquiry>();

  void enquiryCategory() {
    globalClient
        .query(
      QueryOptions(
          document: gql(enquiryCategoryQuery),
          fetchPolicy: FetchPolicy.noCache,
          variables: {"first": 1000, "id": widget.id}),
    )
        .then(
      (QueryResult result) {
        // log('Enquries : ${result.toString()}');
        categoryEnquiries =
            EnquiresHelper.enquiryCategory(result.data) ?? [].cast<Enquiry>();
        setState(() {
          isLoading = false;
        });
      },
    ).catchError(
      (error) {
        log("$error");
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  void initState() {
    enquiryCategory();
    super.initState();
  }
  /*List<Enquiry> enquiries = [
    Enquiry(
      header: 'this is question number1',
      body: 'this is answer of question number1',
      isExpanded: false,
    ),
    Enquiry(
      header: 'this is question number2',
      body: 'this is answer of question number2',
      isExpanded: false,
    ),
    Enquiry(
      header: 'this is question number3',
      body: 'this is answer of question number3',
      isExpanded: false,
    ),
    Enquiry(
      header: 'this is question number4',
      body: 'this is answer of question number4',
      isExpanded: false,
    ),
    Enquiry(
      header: 'this is question number5',
      body: 'this is answer of question number5',
      isExpanded: false,
    ),
  ];*/

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : categoryEnquiries.isEmpty
            ? Center(
                child: Text("There is No Enquiries for this Categories"),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: ExpansionPanelList(
                      elevation: 0,
                      dividerColor: Colors.transparent,
                      //expandedHeaderPadding: EdgeInsets.only(top: 0),
                      children: categoryEnquiries
                          .map(
                            (enquiryItem) => ExpansionPanel(
                                backgroundColor: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor,
                                canTapOnHeader: true,
                                headerBuilder: (context, isOpen) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, top: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            enquiryItem.header,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                body: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, bottom: 18),
                                  child: Column(
                                    children: [
                                      Align(
                                        child: Text(enquiryItem.body,
                                            style: Theme.of(context)
                                                .textTheme
                                                .button),
                                        alignment: Alignment.centerLeft,
                                      ),
//                                  const Divider(
//                                    thickness: 1,
//                                  ),
                                    ],
                                  ),
                                ),
                                isExpanded: enquiryItem.isExpanded),
                          )
                          .toList(),
                      expansionCallback: (index, isOpen) => setState(() {
                        categoryEnquiries[index].isExpanded = !isOpen;
                        //   _isOpen[index] = !isOpen;
                      }),
                    ),
                  ),
                ),
              );
  }
}
