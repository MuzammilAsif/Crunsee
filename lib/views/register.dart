import 'package:crunsee/Backend.dart';
import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController username = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    Backend backend = Backend();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Customappbar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A00E0), // Example purple
              Color(0xFF8E2DE2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network('/lib/assets/images/logo.png', height: 150),
                const SizedBox(height: 24),

                /// Email
                TextField(
                  controller: email,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Email'),
                ),
                const SizedBox(height: 16),

                /// Password
                TextField(
                  controller: password,
                  obscureText: _isPasswordHidden,
                  style: const TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Password').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                /// Confirm Password
                TextField(
                  controller: confirmPassword,
                  obscureText: _isConfirmPasswordHidden,
                  style: const TextStyle(color: Colors.white),
                  decoration:
                      _buildInputDecoration('Confirm Password').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                /// Login redirect
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
                        Get.to(() => const Loginscreen());
                      },
                      child: const Text(
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
                const SizedBox(height: 24),

                /// Register Button
                ElevatedButton(
                  onPressed: () {
                    backend.signup(email.text, password.text);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    minimumSize: const Size(150, 60),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Register Now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white10,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.lightBlueAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
