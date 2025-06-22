import 'package:crunsee/CustomWidgets/customDrawer.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(title: Text('Change Password'), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
