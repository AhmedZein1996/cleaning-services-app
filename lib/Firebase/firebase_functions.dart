import 'dart:developer';

import 'package:clean_services_app/screens/FirstTimeUserAppear/first_time_user_screen.dart';
import 'package:clean_services_app/screens/Home/home_screen.dart';
import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../utilities/constants.dart';

class FirebaseFunctions extends ChangeNotifier {
  bool isLoading = false;
  User? usr;
  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(
    context,
  ) async {
    isLoading = true;
    notifyListeners();
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) {
      isLoading = false;
      notifyListeners();
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
/*    isLoading = false;
    notifyListeners();*/
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      log("Succeeeeeess");
      log("Succeeeeeess");
      usr = FirebaseAuth.instance.currentUser;
      log("Usr ${user.email.toString()}");
      accessWithGoogle(
          usr!.email.toString(), usr!.displayName.toString(), context);
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
    });
    //print('This is tooooooooooooooooooooooken${googleAuth.accessToken}');
  }

  Future logOut() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
  }

  dynamic getUid() {
    //print('This is Uid${usr?.uid}');
    return usr?.uid;
  }

  void accessWithGoogle(String email, String displayName, context) {
    log("from accessWithGoogle");
    globalClient
        .mutate(MutationOptions(
            document: gql(signInWithGoogleMutation),
            variables: {"email": email, "name": displayName}))
        .then((result) {
      log("from then");
      log("result : $result");
      isLoading = false;
      storeToken(result.data!["accessWithGoogle"]["access_token"], context);
    }).catchError((exeption) {
      log("resultERROR : $exeption");
      isLoading = false;
    });
  }

  storeToken(token, BuildContext context) {
    CachedHelper.putValue(kTokenKey, token);
    if (CachedHelper.isGiftTaken()) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(FirstTimeUserScreen.routeName);
    }
  }
}
