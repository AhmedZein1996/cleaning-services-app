import 'dart:developer';

import 'package:clean_services_app/model/feedback.dart';
import 'package:clean_services_app/server/databases/feedbacks_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = true;
  List<FeedbackModel> feedbacks = [].cast<FeedbackModel>();

  getFeedbacks() {
    globalClient
        .query(QueryOptions(
            document: gql(feedbacksQuery), fetchPolicy: FetchPolicy.noCache))
        .then(
      (result) {
        log('feedbacks: ${result.data}');
        feedbacks = FeedbackHelper.feedback(result.data);
        setState(() {
          _isLoading = false;
        });
      },
    ).catchError((error) {
      log("$error");
    });
  }

  @override
  void initState() {
    getFeedbacks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (feedbacks.isEmpty) {
        return const Center(
          child: Text(
            'There is no Feedback yet let\'s add one',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return ListView.builder(
            itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(
                        feedbacks[index].content,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: feedbacks[index].isReplayed
                          ? Text(
                              feedbacks[index].replay,
                              style: TextStyle(color: Colors.grey.shade600),
                            )
                          : Text(
                              'this feedback has no reply yet!',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                    ),
                  ),
                ),
            itemCount: feedbacks.length);
      }
    }
  }

  /* */
}
