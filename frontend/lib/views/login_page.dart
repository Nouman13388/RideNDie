// views/login_page.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/views/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  final SharedPreferences prefs;

  const LoginPage({super.key, required this.prefs});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    await _authController.initSharedPreferences(
        _emailController, _passwordController, widget.prefs);
    setState(() {
      _rememberMe = widget.prefs.getBool('rememberMe') ?? false;
    });
  }

  Future<void> _authenticateUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential? userCredential = await _authController.signInWithEmail(
          _emailController.text, _passwordController.text);

      await _authController.saveCredentials(widget.prefs, _emailController.text,
          _passwordController.text, _rememberMe);

      _emailController.clear();
      _passwordController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign In successful.'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MyBottomNavigationBar(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _guestSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.signInAnonymously();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Guest sign-in successful.'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyBottomNavigationBar(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.signInWithGoogle();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google sign-in successful.'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyBottomNavigationBar(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _logout() async {
    await _authController.signOut();
    await _authController.clearCredentials(widget.prefs);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logout successful.'),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          prefs: widget.prefs,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                'Login to your Account',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text(
                        'Remember Me',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          _isLoading ? null : () => _authenticateUser(context),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Sign in'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Or sign in with',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _isLoading ? null : _signInWithGoogle,
                    child: Container(
                      width: 80,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.google,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: _isLoading ? null : _guestSignIn,
                    child: Container(
                      width: 80,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                child: Text(
                  "Don't have an account? Sign up",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.blue,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
