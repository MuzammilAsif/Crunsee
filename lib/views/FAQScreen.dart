import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  static const List<Map<String, String>> faqs = [
    {
      "question": "How does the currency converter work?",
      "answer":
          "Our app uses real-time exchange rates from reliable financial APIs to convert currencies. Simply select the source and target currency, enter the amount, and get instant results."
    },
    {
      "question": "Are the exchange rates live or delayed?",
      "answer":
          "We fetch live rates, updated every few minutes depending on API response. However, minor delays may occur due to server or network lag."
    },
    {
      "question": "Can I convert any currency?",
      "answer":
          "The app supports 150+ currencies including USD, EUR, GBP, PKR, INR, and many more. If a currency is missing, it may not be supported by our data provider."
    },
    {
      "question": "Does this app work offline?",
      "answer":
          "No, internet connection is required to fetch live exchange rates. You must be connected to convert currency values."
    },
    {
      "question": "Is this app free to use?",
      "answer":
          "Yes, this app is completely free with unlimited conversions. No signup required."
    },
    {
      "question": "Is my data stored or tracked?",
      "answer":
          "No personal data is collected or stored. We respect your privacy and don’t track your usage or store sensitive info."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: const Text(
          '❓ Frequently Asked Questions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.blue.withOpacity(0.1),
              ),
              child: ExpansionTile(
                collapsedIconColor: Colors.blueAccent,
                iconColor: Colors.blueAccent,
                title: Text(
                  faqs[index]["question"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      faqs[index]["answer"]!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
