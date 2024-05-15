import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/blogs_page.dart';
import 'package:frontend/screens/chat_page.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/screens/my_ads_page.dart';
import 'package:frontend/screens/publish_add.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(), // Removed const keyword
      const MyAdsScreen(),
      const ChatScreen(),
      const BlogsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PublishAdScreen()),
          );
        },
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60.0, // Set a height for the BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  CupertinoIcons.home,
                  color: _selectedIndex == 0 ? Colors.indigo : Colors.black,
                ),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(
                  CupertinoIcons.list_bullet,
                  color: _selectedIndex == 1 ? Colors.indigo : Colors.black,
                ),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(), // This SizedBox is for center space, as the FAB is centered
              IconButton(
                icon: Icon(
                  CupertinoIcons.chat_bubble,
                  color: _selectedIndex == 2 ? Colors.indigo : Colors.black,
                ),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(
                  CupertinoIcons.book,
                  color: _selectedIndex == 3 ? Colors.indigo : Colors.black,
                ),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
