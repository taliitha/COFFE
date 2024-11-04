import 'package:coffe/screens/auth_screen.dart';
import 'package:coffe/screens/home_screen.dart';
import 'package:coffe/utils/session_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appwrite Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
              future:
                  SessionManager.isLoggedIn(), // Check login status on startup
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading state
                } else if (snapshot.hasData && snapshot.data == true) {
                  return HomeScreen(); // User is logged in
                } else {
                  return AuthScreen(); // User is not logged in
                }
              },
            ),
        '/auth': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
