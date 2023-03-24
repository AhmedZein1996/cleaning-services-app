import 'package:clean_services_app/screens/Feedbacks/feedbacks_screen.dart';
import 'package:clean_services_app/screens/Feedback/feedback_screen.dart';
import 'package:clean_services_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class FeedbackTabsScreen extends StatefulWidget {
  static const String routeName = "feedback_tabs";

  const FeedbackTabsScreen({Key? key}) : super(key: key);

  @override
  _FeedbackTabsScreenState createState() => _FeedbackTabsScreenState();
}

class _FeedbackTabsScreenState extends State<FeedbackTabsScreen> {
  int _selectedPageIndex = 0;
  final List<Widget> _pages = [
    const FeedbackScreen(),
    const FeedbacksScreen(),
  ];

  _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,

      // selectedItemColor: kPrimaryColor,
     //   unselectedItemColor: Colors.grey.withOpacity(.8),
        onTap: (index) {
          _selectedPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: '',
          ),
        ],
      ),
    );
  }
}
