import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/CustomWidgets/customDrawer.dart';
import 'package:crunsee/views/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:crunsee/views/search.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

final List<Map<String, String>> dummyNotifications = [
  {
    "title": "Exchange Rate Updated",
    "message": "1 USD is now equal to 278.50 PKR.",
  },
  {
    "title": "New Currency Added",
    "message": "You can now convert between PKR and AED.",
  },
  {
    "title": "App Update Available",
    "message":
        "Version 2.1 includes improved conversion accuracy and new features.",
  },
  {
    "title": "Conversion Tip",
    "message": "Use currency history graphs to make better decisions.",
  },
];

class NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      dummyNotifications[index]["title"]!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      dummyNotifications[index]["message"]!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing:
                        const Icon(Icons.notifications, color: Colors.white),
                  );
                },
              ),
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
        onTap: (index) {
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
              MaterialPageRoute(
                  builder: (context) => const NotificationScreen()),
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
