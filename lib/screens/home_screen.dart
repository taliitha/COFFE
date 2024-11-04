import 'package:coffe/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:coffe/pages/account_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  int _currentIndex = 0;
  String _userName = "Loading...";
  String _userEmail = "Loading..."; // Tambahkan variabel email pengguna

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _userName = user?.name ?? "Pengguna";
      _userEmail =
          user?.email ?? "pengguna@example.com"; // Ambil email pengguna
      _pages.addAll([
        HomeTab(userName: _userName),
        VoucherTab(),
        OrdersTab(),
        AccountPage(
          userName: _userName,
          userEmail: _userEmail,
          onLogout: _logout, // Tambahkan fungsi logout
        ),
      ]);
    });
  }

  Future<void> _logout() async {
    await _authService.logout();
    // Arahkan kembali ke layar login
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Coffee Hub',
          style: TextStyle(
            color: Colors.brown[800],
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: _pages.isEmpty
          ? Center(child: CircularProgressIndicator())
          : _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.brown[800],
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Voucher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}

// Home tab widget with userName parameter
class HomeTab extends StatelessWidget {
  final String userName;

  const HomeTab({required this.userName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_picture.png'),
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(height: 20),
            Text(
              'Halo, $userName!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Temukan kopi favorit Anda',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            _buildPromotionBanner(),
            SizedBox(height: 30),
            _buildMenuOption(
              icon: Icons.local_cafe,
              label: 'Pesan Kopi',
              onTap: () {
                // Navigasi ke layar pemesanan
              },
            ),
            _buildMenuOption(
              icon: Icons.location_on,
              label: 'Cari Kafe Terdekat',
              onTap: () {
                // Navigasi ke layar pencarian kafe
              },
            ),
            _buildMenuOption(
              icon: Icons.history,
              label: 'Riwayat Pesanan',
              onTap: () {
                // Navigasi ke layar riwayat pesanan
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionBanner() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[100],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(Icons.local_offer, size: 28, color: Colors.brown[800]),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Penawaran Terbatas: Diskon 20% untuk kopi berikutnya!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.brown[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.brown[100],
          child: Icon(icon, color: Colors.brown[800]),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.brown[800],
          ),
        ),
        trailing:
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.brown[800]),
        onTap: onTap,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// Define other tabs like Voucher and Orders
class VoucherTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Halaman Voucher', style: TextStyle(fontSize: 20)),
    );
  }
}

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Halaman Pesanan', style: TextStyle(fontSize: 20)),
    );
  }
}
