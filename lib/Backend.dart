import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crunsee/views/DetailedUserInfo.dart';
import 'package:crunsee/views/FeedbackScreen.dart';
import 'package:crunsee/views/MainScreen.dart';
import 'package:crunsee/views/homepage.dart';
import 'package:crunsee/views/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Backend {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference UserData =
      FirebaseFirestore.instance.collection("UserInfo");
  //function for signup
  Future<void> signup(String useremail, String userpassword) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: useremail, password: userpassword);
      //navigating user to detailed user info screen
      Get.to(Detaileduserinfo());
    } catch (error) {
      Get.snackbar("Alert", "$error");
    }
  }

  //Functionality of login
  Future<void> signin(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //navigating user to home screen
      Get.to(HomeScreen());
      getLoggedInUserData();
    } catch (e) {
      Get.snackbar("Alert", "$e");
    }
  }

  //Create
  Future<void> insertUserData(
      String name, String age, String gender, String imgurl) async {
    // Get the currently logged-in user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if user is null (not logged in)
    if (user == null) {
      print("Error: No user is currently logged in.");
      return;
    }

    try {
      // Insert user data into Firestore under their UID
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(user.uid)
          .set({
        "Username": name,
        "age": age,
        "gender": gender,
        "imgurl": imgurl,
      });

      print("User data inserted for UID: ${user.uid}");
      Get.to(HomeScreen()); // Navigate to HomeScreen after inserting data
    } catch (e) {
      print("Failed to insert user data: $e");
    }
  }

  Future<Map<String, dynamic>?> getLoggedInUserData() async {
    try {
      // Get current user UID
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("No user logged in.");
        return null;
      }

      // Fetch user document
      DocumentSnapshot doc = await UserData.doc(user.uid).get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print("User  not found ");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  // Function to update user data
  Future<void> updateUserData({String? username, String? password, String? imgurl}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  // Create a map of fields to update
  Map<String, dynamic> updates = {};

  if (username != null && username.isNotEmpty) {
    updates['Username'] = username;
  }
  if (password != null && password.isNotEmpty) {
    updates['password'] = password;
  }
  if (imgurl != null && imgurl.isNotEmpty) {
    updates['imgurl'] = imgurl;
  }

  if (updates.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(user.uid)
        .update(updates);
  } else {
    print("No fields to update");
  }
}

  Future<void> sendFeedbackToEmail(String feedback) async {
    const serviceId = 'service_7dqdnkf';
    const templateId = 'template_651tzii';
    const userId = 'L71CTVW09APIvJKGr';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'feedback': feedback,
          'user_email': 'YourUser@example.com', // optional
        },
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(FeedbackScreen() as BuildContext).showSnackBar(
        const SnackBar(
          content: Text(
            "Thank you for your valuable feedback!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print("❌ Failed to send email: ${response.body}");
    }
  }

  //function fo rthe graphql api
  
  

}
