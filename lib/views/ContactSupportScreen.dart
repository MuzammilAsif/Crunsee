// lib/views/ContactSupportScreen.dart (or wherever you prefer to place your screens)
import 'package:flutter/material.dart';
// You might need to add url_launcher package for actual email/phone intents
// import 'package:url_launcher/url_launcher.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  // Function to launch email client (requires url_launcher package)
  // Future<void> _launchEmail(String emailAddress) async {
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: emailAddress,
  //     queryParameters: {'subject': 'Support Inquiry from Worky Café App'},
  //   );
  //   if (await canLaunchUrl(emailLaunchUri)) {
  //     await launchUrl(emailLaunchUri);
  //   } else {
  //     // Fallback for when the email app can't be launched
  //     print('Could not launch $emailLaunchUri');
  //     // Optionally show a SnackBar or AlertDialog
  //   }
  // }

  // Function to launch phone dialer (requires url_launcher package)
  // Future<void> _launchPhone(String phoneNumber) async {
  //   final Uri phoneLaunchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   if (await canLaunchUrl(phoneLaunchUri)) {
  //     await launchUrl(phoneLaunchUri);
  //   } else {
  //     // Fallback for when the dialer can't be launched
  //     print('Could not launch $phoneLaunchUri');
  //     // Optionally show a SnackBar or AlertDialog
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Support',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Need assistance? Reach out to us through the following channels:',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),

          // Contact via Email
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.email, color: Colors.blueAccent),
              title: const Text(
                'Email Support',
                // style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'support@workycafe.com',
                // style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                print(
                    'Attempting to open email client to support@workycafe.com');
                // Uncomment the line below and add url_launcher if you want to launch email app
                // _launchEmail('support@workycafe.com');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                    'Email support not yet integrated. Copy email address.',
                    style: TextStyle(color: Colors.white),
                  )),
                );
              },
            ),
          ),

          // Contact via Phone
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text(
                'Call Us',
                // style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                '+92 3XX XXXXXXX (Mon-Fri, 9 AM - 5 PM)',
                // style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                print('Attempting to open phone dialer for +92 3XX XXXXXXX');
                // Uncomment the line below and add url_launcher if you want to launch dialer
                // _launchPhone('+923XXXXXXXXX');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                    'Phone call not yet integrated. Call manually.',
                    style: TextStyle(color: Colors.white),
                  )),
                );
              },
            ),
          ),

          // Placeholder for other contact methods (e.g., WhatsApp, Live Chat)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.chat, color: Colors.purple),
              title: const Text(
                'Live Chat (Coming Soon)',
                // style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Connect with a support agent instantly.',
                // style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                print('Live Chat feature is coming soon!');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                    'Live Chat feature is coming soon!',
                    style: TextStyle(color: Colors.white),
                  )),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            'For urgent matters, please call us directly during business hours.',
            textAlign: TextAlign.center,
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
