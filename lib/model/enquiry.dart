class Enquiry {
  String header;
  String body;
  bool isExpanded;

  Enquiry({
    required this.header,
    required this.body,
    this.isExpanded = false,
  });
}
