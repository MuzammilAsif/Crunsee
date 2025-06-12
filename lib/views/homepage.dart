import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: Customappbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(
              'Welcome to Crunsee!',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 Navigator.pushNamed(context, '/welcomePage');
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}