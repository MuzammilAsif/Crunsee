import 'package:crunsee/CustomWidgets/CurrencyChart.dart';
import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/CustomWidgets/customDrawer.dart';
import 'package:crunsee/data/network/api_services.dart';
import 'package:crunsee/model/rates_model.dart';
import 'package:crunsee/views/widgets/conversion_card.dart';
import 'package:crunsee/views/notification.dart';
import 'package:crunsee/views/MainScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:crunsee/CustomWidgets/CurrencyChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:crunsee/data/network/api_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RatesModel> ratesModel;
  late Future<Map> currenciesModel;
  Future<List<FlSpot>> fetchHistoricalRates(String base, String target) async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    final url = Uri.parse(
      'https://api.exchangerate.host/timeseries'
      '?start_date=${sevenDaysAgo.toIso8601String().substring(0, 10)}'
      '&end_date=${now.toIso8601String().substring(0, 10)}'
      '&base=$base&symbols=$target',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final Map<String, dynamic> rates = data['rates'];

      List<FlSpot> spots = [];
      int index = 0;
      for (String date in rates.keys.toList()..sort()) {
        final rate = rates[date][target];
        if (rate != null) {
          spots.add(FlSpot(index.toDouble(), rate.toDouble()));
          index++;
        }
      }

      return spots;
    } else {
      throw Exception('Failed to load historical rates');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    ratesModel = fetchRates();
    currenciesModel = fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Customappbar(),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<RatesModel>(
                future: ratesModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return FutureBuilder<Map>(
                        future: currenciesModel,
                        builder: (context, index) {
                          if (index.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (index.hasError) {
                            return Center(child: Text('Error: ${index.error}'));
                          } else {
                            return ConversionCard(
                              rates: snapshot.data!.rates,
                              currencies: index.data!,
                            );
                          }
                        });
                  }
                }),
          ),
          FutureBuilder<List<FlSpot>>(
            future: fetchHistoricalRates("USD", "PKR"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Currencychart(spots: snapshot.data!);
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        index: 1,
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
