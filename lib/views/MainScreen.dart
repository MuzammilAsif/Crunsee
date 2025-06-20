import 'package:crunsee/Backend.dart';
import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/CustomWidgets/customDrawer.dart';
import 'package:crunsee/views/search.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:crunsee/views/notification.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}
class ExchangeRates {
  final Map<String, dynamic> rates;

  ExchangeRates({required this.rates});

  factory ExchangeRates.fromJson(Map<String, dynamic> json) {
    return ExchangeRates(rates: json['conversion_rates']);
  }
}
 Future<ExchangeRates> fetchExchangeRates() async {
  final url = Uri.parse('https://v6.exchangerate-api.com/v6/b2cd243453688f5ef8eab529/latest/USD');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return ExchangeRates.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load exchange rates');
  }
}
class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(),
      drawer: Customdrawer(),
      backgroundColor: const Color(0xFF1C1C1E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ExchangeRates>(
          future: fetchExchangeRates(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              final rates = snapshot.data!.rates;

              final pairs = [
                {'pair': 'USD/PKR', 'rate': rates['PKR'], 'isUp': true},
                {
                  'pair': 'EUR/PKR',
                  'rate': rates['EUR'] / rates['PKR'],
                  'isUp': false,
                },
                {
                  'pair': 'GBP/PKR',
                  'rate': rates['GBP'] / rates['PKR'],
                  'isUp': true,
                },
                {
                  'pair': 'AUD/PKR',
                  'rate': rates['AUD'] / rates['PKR'],
                  'isUp': false,
                },
                {
                  'pair': 'CAD/PKR',
                  'rate': rates['CAD'] / rates['PKR'],
                  'isUp': true,
                },
                {
                  'pair': 'SAR/PKR',
                  'rate': rates['SAR'] / rates['PKR'],
                  'isUp': true,
                },
              ];

              return GridView.builder(
                itemCount: pairs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  final item = pairs[index];
                  return CurrencyBox(
                    pair: item['pair'],
                    rate: (item['rate'] as double).toStringAsFixed(2),
                    isUp: item['isUp'],
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        index: 0,
        color: Colors.blue,
        animationDuration: const Duration(milliseconds: 300),
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
                builder: (context) => const NotificationScreen(),
              ),
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
