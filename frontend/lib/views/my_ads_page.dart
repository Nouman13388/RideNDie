import 'package:flutter/material.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  void _fetchData() {
    // Method to fetch data for the my ads screen
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Ads',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 30.0),
        ),
      ),
      body: const Center(
        child: Text('My Ads Screen'),
      ),
    );
  }
}
