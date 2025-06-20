import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:crunsee/data/network/api_services.dart';
import 'package:crunsee/model/rates_model.dart';
import 'package:crunsee/views/widgets/conversion_card.dart';
import 'package:crunsee/views/notification.dart';
import 'package:crunsee/views/MainScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RatesModel> ratesModel;
  late Future<Map> currenciesModel;

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
      body: FutureBuilder<RatesModel>(
        future: ratesModel,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return FutureBuilder<Map>(
                future: currenciesModel,
                builder: (context, index){
                  if (index.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(),);
                  } else if (index.hasError) {
                    return Center(child: Text('Error: ${index.error}'));
                  } else {
                    return ConversionCard(
                      rates: snapshot.data!.rates,
                      currencies: index.data!,
                    );
                  }
                }
            );
          }
        }
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        index: 1,
        color: Colors.blue,
        animationDuration: const Duration(milliseconds: 300),
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
