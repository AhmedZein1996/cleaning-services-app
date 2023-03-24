// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Clean Services`
  String get appName {
    return Intl.message(
      'Clean Services',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an Account ? `
  String get dont_have_account {
    return Intl.message(
      'Don’t have an Account ? ',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an Account ? `
  String get already_have_an_account {
    return Intl.message(
      'Already have an Account ? ',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `without deduction`
  String get without_deduction {
    return Intl.message(
      'without deduction',
      name: 'without_deduction',
      desc: '',
      args: [],
    );
  }

  /// `Enquires`
  String get enquires {
    return Intl.message(
      'Enquires',
      name: 'enquires',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `this feedback has no reply yet!`
  String get feedback_is_not_replay_yet {
    return Intl.message(
      'this feedback has no reply yet!',
      name: 'feedback_is_not_replay_yet',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'your feedbacks' key

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `When can we clean?`
  String get when_we_can_clean {
    return Intl.message(
      'When can we clean?',
      name: 'when_we_can_clean',
      desc: '',
      args: [],
    );
  }

  /// `No lock in contract - no commitment`
  String get no_lock_in_contract_no_commitment {
    return Intl.message(
      'No lock in contract - no commitment',
      name: 'no_lock_in_contract_no_commitment',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Swedich`
  String get swedich {
    return Intl.message(
      'Swedich',
      name: 'swedich',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Create New Feedback`
  String get create_new_feedback {
    return Intl.message(
      'Create New Feedback',
      name: 'create_new_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Let us know how to improve our app`
  String get let_us_know_how_to_improve_our_app {
    return Intl.message(
      'Let us know how to improve our app',
      name: 'let_us_know_how_to_improve_our_app',
      desc: '',
      args: [],
    );
  }

  /// `Order cleaning`
  String get order_cleaning {
    return Intl.message(
      'Order cleaning',
      name: 'order_cleaning',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sv', countryCode: 'SE'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
