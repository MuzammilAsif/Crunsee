
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ConversionHistoryScreen extends StatefulWidget {
  const ConversionHistoryScreen({super.key});

  @override
  State<ConversionHistoryScreen> createState() => _ConversionHistoryScreenState();
}

class _ConversionHistoryScreenState extends State<ConversionHistoryScreen> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('conversion_history',) ?? [];

    setState(() {
      _history = stored.map((item) => jsonDecode(item) as Map<String, dynamic>).toList().reversed.toList();
    });
  }

  // ✅ Call this method wherever you perform a currency conversion
  static Future<void> saveConversion({
    required String from,
    required String to,
    required double amount,
    required double convertedAmount,
    required double rate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existing = prefs.getStringList('conversion_history') ?? [];

    final newEntry = jsonEncode({
      'from': from,
      'to': to,
      'amount': amount,
      'converted': convertedAmount,
      'rate': rate,
      'date': DateTime.now().toIso8601String(),
    });

    existing.add(newEntry);
    await prefs.setStringList('conversion_history', existing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: _history.isEmpty
          ? const Center(child: Text('No conversion history yet.',style: TextStyle(color: Colors.white),))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.history),
                    title: Text("${item['amount']} ${item['from']} → ${item['converted']} ${item['to']}"),
                    subtitle: Text(
                      "Rate: ${item['rate']} | ${DateFormat.yMMMd().add_jm().format(DateTime.parse(item['date']))}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
