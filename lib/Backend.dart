import 'package:crunsee/views/MainScreen.dart';
import 'package:crunsee/views/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Backend {
  FirebaseAuth auth = FirebaseAuth.instance;
    //function for signup
  Future<void> signup(String useremail, String userpassword) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: useremail, password: userpassword);
      //navigating user to MainScreen
      Get.to(Mainscreen());
    } catch (error) {
      Get.snackbar("Alert", "$error");
    }
  }

  //Functionality of login
  Future<void> signin(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //navigating user to home page
      Get.to(Mainscreen());
    } catch (e) {
      Get.snackbar("Alert", "$e");
    }
  }
}


