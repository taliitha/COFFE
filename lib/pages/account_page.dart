import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onLogout;

  const AccountPage({
    required this.userName,
    required this.userEmail,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Akun'),
        centerTitle: true,
        backgroundColor: Colors.brown[800],
      ),
      body: Stack(
        children: [
          // Background decoration
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.brown[200]!, Colors.brown[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // User avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/profile_picture.png'),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Halo, $userName!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: $userEmail',
                    style: TextStyle(fontSize: 18, color: Colors.brown[600]),
                  ),
                  SizedBox(height: 30),
                  _buildLogoutButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onLogout(); // Call the onLogout function
        Navigator.of(context)
            .pushReplacementNamed('/auth'); // Navigate to AuthScreen
      },
      child: Text('Keluar'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown[800], // Button background color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
