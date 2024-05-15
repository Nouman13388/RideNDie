import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences? prefs;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    prefs = await SharedPreferences.getInstance();
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing Firebase or SharedPreferences: $e');
    }
  }
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  SharedPreferences? prefs;
  
  MyApp({super.key, this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(prefs: prefs!),
    );
  }
}

