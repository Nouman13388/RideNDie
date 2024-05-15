import 'package:flutter/material.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  void _fetchData() {
    // Method to fetch data for the blogs screen
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
        title: const Text('Blogs',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 30.0)),
      ),
      body: const Center(
        child: Text('Blogs Screen'),
      ),
    );
  }
}
