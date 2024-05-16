import 'package:flutter/material.dart';

class NewsPreferencesPage extends StatelessWidget {
  const NewsPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Preferences'),
      ),
      body: const Center(
        child: Text('News Preferences Page'),
      ),
    );
  }
}
