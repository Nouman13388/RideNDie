import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/screens/login_page.dart';
import 'package:frontend/screens/profile_pages/account_setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'news_preferences_page.dart';
import 'notification_preference_page.dart';
import 'privacy_policy_page.dart';
import 'terms_of_service_page.dart';

class ProfilePage extends StatelessWidget {
  final SharedPreferences prefs;

  const ProfilePage({super.key, required this.prefs});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          prefs: prefs,
        ),
      ),
      (Route<dynamic> route) => false, // Prevent going back to home
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Account'),
            leading: const Icon(Icons.account_circle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountSettingsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Notification Preferences'),
            leading: const Icon(Icons.notifications),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationPreferencesPage()),
              );
            },
          ),
          ListTile(
            title: const Text('News Preferences'),
            leading: const Icon(Icons.article),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPreferencesPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            leading: const Icon(Icons.description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsOfServicePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () => _logout(context), // Pass context here
          ),
        ],
      ),
    );
  }
}
