import 'package:clean_services_app/Screens/Contactus/contactus_screen.dart';
import 'package:clean_services_app/Screens/Enquiries/enquiries_screen.dart';
import 'package:clean_services_app/Screens/Order/order_screen.dart';
import 'package:clean_services_app/Screens/Profile/profile_screen.dart';
import 'package:clean_services_app/Screens/Signup/signup_screen.dart';
import 'package:clean_services_app/Screens/Welcome/welcome_screen.dart';
import 'package:clean_services_app/screens/Feedback/feedback_screen.dart';
import 'package:clean_services_app/screens/FeedbackTabs/feedback_tabs_screen.dart';
import 'package:clean_services_app/screens/FirstTimeUserAppear/first_time_user_screen.dart';
import 'package:clean_services_app/screens/Newuser/newuser_screen.dart';
import 'package:clean_services_app/screens/OrderHistory/order_history_screen.dart';
import 'package:clean_services_app/screens/Payment/components/payment_web_view.dart';
import 'package:clean_services_app/screens/Payment/payment_screen.dart';
import 'package:clean_services_app/screens/ScratchingCards/scratching_screen.dart';
import 'package:clean_services_app/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

import '../Screens/Home/home_screen.dart';
import '../Screens/Login/login_screen.dart';

//// We use name route
//// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  EnquiriesScreen.routeName: (context) => const EnquiriesScreen(),
  ContactUsScreen.routeName: (context) => const ContactUsScreen(),
  OrderHistoryScreen.routeName: (context) => const OrderHistoryScreen(),
  FeedbackScreen.routeName: (context) => const FeedbackScreen(),
  FeedbackTabsScreen.routeName: (context) => const FeedbackTabsScreen(),
  ScratchingScreen.routeName: (context) => const ScratchingScreen(),
  FirstTimeUserScreen.routeName: (context) => const FirstTimeUserScreen(),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
  PaymentScreen.routeName: (context) => const PaymentScreen(),
  PaymentWebView.routeName: (context) => const PaymentWebView(),
  NewUserScreen.routeName: (context) => const NewUserScreen(),
};
