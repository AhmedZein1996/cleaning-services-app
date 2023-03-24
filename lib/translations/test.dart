void main() {
  Map<String, dynamic> x = {
    "appName": "Clean Services",
    "contactUs": "Contact Us",
    "profile": "Profile",
    "dont_have_account": "Don’t have an Account ? ",
    "already_have_an_account": "Already have an Account ? ",
    "without_deduction": "without deduction",
    "enquires": "Enquires",
    "error": "Error",
    "orders": "Orders",
    "feedback_is_not_replay_yet": "this feedback has no reply yet!",
    "your feedbacks": "Your Feedbacks",
    "information": "Information",
    "when_we_can_clean": "When can we clean?",
    "no_lock_in_contract_no_commitment": "No lock in contract - no commitment",
    "english": "English",
    "swedich": "Swedich",
    "loading": "Loading",
    "payment": "Payment",
    "send": "Send",
    "create_new_feedback": "Create New Feedback",
    "let_us_know_how_to_improve_our_app": "Let us know how to improve our app",
    "order_cleaning": "Order cleaning"
  };
  List<Map> y = [];
  y = x['covers'];

  print(x['data']['covers'][0]['cover_detail']['cover_name']);
}
