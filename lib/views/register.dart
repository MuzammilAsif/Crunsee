import 'package:crunsee/Backend.dart';
import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Register extends StatelessWidget {

TextEditingController email = TextEditingController();
TextEditingController Username = TextEditingController();
TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Backend backend = Backend();
    return Scaffold(
      appBar: Customappbar(),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///// Page Code/////
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField( //Username field
                      decoration: InputDecoration(
                        labelText: 'UserName',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.lightBlueAccent, // Light blue when inactive
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color:Theme.of(context).colorScheme.primary, // Dark blue from theme
                            color: Colors.blue, // Dark blue from theme
                            width: 2,
                          ),
                        ),
                      ),
                      controller: email,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextField( //Email field
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.lightBlueAccent, // Light blue when inactive
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color:Theme.of(context).colorScheme.primary, // Dark blue from theme
                            color: Colors.blue, // Dark blue from theme
                            width: 2,
                          ),
                        ),
                      ),
                      controller: email,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent, // Light blue when inactive
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color:Theme.of(context).colorScheme.primary, // Dark blue from theme
                            color: Colors.blue, // Dark blue from theme
                            width: 2,
                          ),
                        ),
                      ),
                      controller: password,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextField( //confirm password field
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent, // Light blue when inactive
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color:Theme.of(context).colorScheme.primary, // Dark blue from theme
                            color: Colors.blue, // Dark blue from theme
                            width: 2,
                          ),
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Loginscreen()); // Navigate to Register page
                          },
                          child: Text(
                            'Login here',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24), // Space between text and button
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15,),
                    minimumSize: const Size(150, 60), // width, height
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    backend.signup(email.text, password.text);
                  // Handle login logic here
                  },
                  child: const Text('Register Now'),
                ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}