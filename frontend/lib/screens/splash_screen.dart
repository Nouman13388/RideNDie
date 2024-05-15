import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
    const splashDuration = Duration(seconds: 3);

    _timer = Timer(splashDuration, navigateToLoginPage);
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(prefs: prefs)),
    );
  }

  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ride N Die',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            ),
          ],
        ),
      ),
    );
  }
}
