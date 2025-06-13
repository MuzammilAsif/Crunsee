import 'dart:async';
import 'package:crunsee/CustomWidgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class IntroPageWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const IntroPageWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, height: 200),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_controller.hasClients) {
        _currentPage++;
        if (_currentPage >= _totalPages) {
          _currentPage = 0; // Loop back to first page
        }
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.linearToEaseOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  
  @override
Widget build(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF4A00E0), // Example purple
          Color(0xFF8E2DE2), // Lighter purple or any second color
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  child: Stack(
    children: [
      PageView(
        controller: _controller,
        children: const [
          IntroPage(
            imageUrl: '/lib/images/currency-exchange-icon-on-dark-background-vector-37708912-removebg-preview.png',
            title: 'Live Currency Rates',
            subtitle: 'Get up-to-date exchange rates for all major currencies.',
          ),
          IntroPage(
            imageUrl: '/lib/images/linear-graph-chart-icon-vector-20976131-removebg-preview.png',
            title: 'Interactive Charts',
            subtitle: 'Visualize historical data and track market trends easily.',
          ),
          IntroPage(
            imageUrl: '/lib/images/new-message-inbox-notification-vector-icon-two-incoming-email-messages-118842081-removebg-preview.png',
            title: 'Smart Alerts',
            subtitle: 'Set alerts for your desired rates and stay informed.',
          ),
        ],
      ),
      Positioned(
        bottom: 120,
        left: 0,
        right: 0,
        child: Center(
          child: SmoothPageIndicator(
            controller: _controller,
            count: _totalPages,
            effect: WormEffect(
              dotColor: Colors.white38,
              activeDotColor: Colors.white,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 40,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loginPage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF6B4EFF),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Login Now'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/MainScreen');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('Skip'),
            ),
          ],
        ),
      ),
    ],
  ),
);
  }
}

class IntroPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const IntroPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, height: 200),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
