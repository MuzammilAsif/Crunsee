import 'package:crunsee/Backend.dart';
import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Simulate loading delay (1 seconds)
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
  
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Backend backend = Backend();
  @override
  Widget build(BuildContext context) {
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

              ///// Circle Progress Indicator /////
              _isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ):

              ///// Page Code/////
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image.asset('assets/images/logo.png', height: 100),
                    Image.network("https://picsum.photos/200"),
                    const SizedBox(height: 20),
                    TextField(
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
                      controller: emailController,
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
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Register here',
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
                    backend.signin(emailController.text, passwordController.text);
                  // Handle login logic here
                  },
                  child: const Text('Login Now'),
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
