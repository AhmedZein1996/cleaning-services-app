import 'package:clean_services_app/model/feedback.dart';

class FeedbackHelper {
  static feedback(Map<String, dynamic>? data) {
    List<FeedbackModel> feedbacks = [].cast<FeedbackModel>();
    feedbacks = (data!['me']['feedbacks']['data'] as List<dynamic>)
        .map(
          (feedback) => FeedbackModel(
            id: feedback['id'],
            content: feedback['content'],
            isReplayed: feedback['is_replayed'],
            replay: feedback['replay'].toString(),
          ),
        )
        .toList();
    return feedbacks;
  }
}
