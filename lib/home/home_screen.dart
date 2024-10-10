import 'package:flutter/material.dart';
import 'package:my_solonet_app/home/home_page_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    if (index == 3) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        // requiredLoginPopup(context, 'Please login to continue');
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Map<String, dynamic>> recommendedProducts = [
    {
      'title': 'Product 1',
      'price': 150000,
      'category': 'Electronics',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Product 2',
      'price': 200000,
      'category': 'Clothing',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Product 3',
      'price': 120000,
      'category': 'Books',
      'image': 'https://via.placeholder.com/150',
    },
  ];

  final List<Widget> _screens = [
    const HomePageContent(), // Add HomePageContent for the home screen
    // const UpgradeScreen(), // Create an UpgradeScreen widget for the upgrade section
    // const HelpScreen(), // HelpScreen remains the same
    // const ProfileScreen(), // Create a ProfileScreen widget for the profile section
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'SOLONET',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/logo1.png',
                    height: 25,
                  ),
                ],
              ),
              backgroundColor: Colors.blueAccent,
            )
          : null, // Hide AppBar when not on the Home screen
      body: IndexedStack(
        index:
            _selectedIndex, // Switches between screens based on _selectedIndex
        children: _screens, // The list of screens
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Upgrade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, // Change screen on tap without navigation
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle:
            const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
      ),
    );
  }
}
