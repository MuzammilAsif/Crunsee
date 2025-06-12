import 'package:flutter/material.dart';

class Customdrawer extends StatelessWidget {
  const Customdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                  currentAccountPicture: CircleAvatar(child: Text("M"),),
                  accountName: Text("Muzammil Mughal"),
                  accountEmail: Text("abc@gmail.com"),
                ),
              ),
            ),
            ListTile(title: Text('Edit Profile'), onTap: () {}),
            Divider(),
            ListTile(title: Text('App Settings'), onTap: () {}),
            // ListTile(title: Text('Theme'), onTap: () {}),
            Divider(),
            ListTile(title: Text('FAQ'), onTap: () {}),
            ListTile(title: Text('Contact Support'), onTap: () {}),
            Divider(),
            ListTile(title: Text('Logout'), onTap: () {}),
          ],
        ),
      );
  }
}