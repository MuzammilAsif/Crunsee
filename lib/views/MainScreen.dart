import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/CustomWidgets/customDrawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  // Sample data (you can replace it with dynamic API data)
  final List<Map<String, dynamic>> currencyPairs = const [
    {'pair': 'USD/PKR', 'rate': '277.50', 'isUp': true},
    {'pair': 'EUR/PKR', 'rate': '302.10', 'isUp': false},
    {'pair': 'GBP/PKR', 'rate': '353.90', 'isUp': true},
    {'pair': 'AUD/PKR', 'rate': '185.00', 'isUp': false},
    {'pair': 'CAD/PKR', 'rate': '205.20', 'isUp': true},
    {'pair': 'SAR/PKR', 'rate': '74.12', 'isUp': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(),
      drawer: Customdrawer(),
      backgroundColor: const Color(0xFF1C1C1E), // Dark theme background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: currencyPairs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final item = currencyPairs[index];
            return CurrencyBox(
              pair: item['pair'],
              rate: item['rate'],
              isUp: item['isUp'],
            );
          },
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        color: Colors.blue,
        onTap: (index) {
          // Navigation logic here
        },
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}

class CurrencyBox extends StatelessWidget {
  final String pair;
  final String rate;
  final bool isUp;

  const CurrencyBox({
    super.key,
    required this.pair,
    required this.rate,
    required this.isUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                isUp ? Icons.trending_up : Icons.trending_down,
                color: isUp ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  pair,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Text(
            rate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
