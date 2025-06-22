import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/CustomWidgets/customDrawer.dart';
// import 'package:crunsee/CustomWidgets/CustomBottomBar.dart';
import 'package:crunsee/views/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:crunsee/views/search.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(),
      drawer:CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                return ListTile(
                title: Text("Notification title", style: TextStyle(color: Colors.white)),
                subtitle: Text("Notification text", style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.notifications, color: Colors.white),
              );
              },),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        index: 2,
        color: Colors.blue,
        // animationDuration: const Duration(milliseconds: 300),
        onTap: (index){
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Mainscreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NotificationScreen()),
            );
          }
        },
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}