import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/views/login_page.dart';
import 'package:frontend/views/profile_pages/account_setting_page.dart';
import 'package:frontend/views/profile_pages/notification_preference_page.dart';
import 'package:frontend/views/profile_pages/privacy_policy_page.dart';
import 'package:frontend/views/profile_pages/terms_of_service_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? _prefs;
  User? _currentUser;
  late Future<void> _initializeFuture;

  @override
  void initState() {
    super.initState();
    _initializeFuture = _initializeUserData();
    _fetchData();
  }

  Future<void> _initializeUserData() async {
    _prefs = await SharedPreferences.getInstance();
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      _prefs!.setString('username', _currentUser!.displayName ?? 'No Name');
      _prefs!.setString('email', _currentUser!.email ?? 'No Email');
    }
    setState(() {});
  }

  void _fetchData() {
    // Method to fetch data for the home screen
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ride N Die',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {
              // Navigator.pushNamed(context, '/search');
            },
          ),
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      drawer: FutureBuilder(
        future: _initializeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            _currentUser?.photoURL ??
                                'https://via.placeholder.com/150', // Default image URL if no photoURL
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _prefs?.getString('username') ?? 'User Name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _prefs?.getString('email') ?? 'user@example.com',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Account'),
                    leading: const Icon(Icons.account_circle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountSettingsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Notification Preferences'),
                    leading: const Icon(Icons.notifications),
                    onTap: () {
                      // Navigate to NotificationPreferencesPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const NotificationPreferencesPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Privacy Policy'),
                    leading: const Icon(Icons.privacy_tip),
                    onTap: () {
                      // Navigate to PrivacyPolicyPage
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyPage()));
                    },
                  ),
                  ListTile(
                    title: const Text('Terms of Service'),
                    leading: const Icon(Icons.description),
                    onTap: () {
                      // Navigate to TermsOfServicePage
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsOfServicePage()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Logout'),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      if (_prefs != null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage(prefs: _prefs!)),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryItem(
                      'https://cdn-icons-png.flaticon.com/128/5035/5035167.png',
                      'Hatchback',
                    ),
                    _buildCategoryItem(
                      'https://cdn-icons-png.flaticon.com/128/1085/1085961.png',
                      'Sedan',
                    ),
                    _buildCategoryItem(
                      'https://cdn-icons-png.flaticon.com/128/2736/2736781.png',
                      'SUV',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured Cars',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Action for view all button
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFeaturedCarItem('Car 1'),
                    _buildFeaturedCarItem('Car 2'),
                    _buildFeaturedCarItem('Car 3'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String imageUrl, String title) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigo),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Image.network(
            imageUrl,
            width: 35,
            fit: BoxFit.cover,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCarItem(String title) {
    return Container(
      width: 280.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Center(child: Text(title)),
    );
  }
}
