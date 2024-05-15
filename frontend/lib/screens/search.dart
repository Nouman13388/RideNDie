import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: Colors.black),
          ),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Search for new and used cars',
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    _textEditingController.clear();
                  });
                },
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Search Screen'),
      ),
    );
  }
}
