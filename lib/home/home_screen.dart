import 'package:flutter/material.dart';
import 'package:my_solonet_app/alert/confirm_popup.dart';
import 'package:my_solonet_app/auth/login.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/home/home_bantuan.dart';
import 'package:my_solonet_app/home/home_bayar_invoce.dart';
import 'package:my_solonet_app/home/home_help.dart';
import 'package:my_solonet_app/home/home_invoice.dart';
import 'package:my_solonet_app/home/home_page_content.dart';
import 'package:my_solonet_app/home/home_pilihan_user.dart';
import 'package:my_solonet_app/home/home_profile.dart';
import 'package:my_solonet_app/home/home_user_baru.dart';
import 'package:my_solonet_app/invoice/invoice_tagihan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 4;
  String idRegister = '';
  String nama = '';
  String email = '';
  String? token;

  Future<void> _loadUserData() async {
    final authService = AuthService();
    token = await authService.getToken();

    if (token != null) {
      final url = Uri.parse('${baseUrl}api/profile');

      try {
        final response = await http.get(url, headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            idRegister = data['id_register'];
            nama = data['name'];
            email = data['email'];
          });
        } else {
          print('Error: ${response.body}');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  void _onItemTapped(int index) async {
    if (index == 0) {
      if (token == null) {
        confirmPopup(
          context,
          'Anda Belum Login',
          // 'Anda Belum Login',
          'Silahkan login terlebih dahulu, untuk mengakses halaman ini',
          'Login',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          ),
        );
      } else {
        final url = Uri.parse('${baseUrl}api/profile');
        try {
          final response = await http.get(url, headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          });

          if (response.statusCode == 401) {
            confirmPopup(
              context,
              'Anda Belum Login',
              'Silahkan login terlebih dahulu, untuk mengakses halaman ini',
              'Login',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              ),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        } catch (e) {
          print('Error checking token: $e');
        }
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // void _onItemTapped(int index) async {
  //   if (index == 4) {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String? token = prefs.getString('token');

  //     if (token == null) {
  //       // requiredLoginPopup(context, 'Please login to continue');
  //     } else {
  //       setState(() {
  //         _selectedIndex = index;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       _selectedIndex = index;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  List<Widget> _screens = [
    const HomeUserBaru(), // Create an UpgradeScreen widget for the upgrade section
    const HomeInvoice(), // Create an InvoiceScreen widget for the invoice section
    const BayarInvoice(), // Create an InvoiceScreen widget for the invoice section
    const HomeBantuan(), // HelpScreen remains the same
    const HomeProfile(), // Create a ProfileScreen widget for the profile section
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
                        'John Doe',
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
                    'assets/images/solonet-logo-white1.png',
                    height: 25,
                  ),
                ],
              ),
              backgroundColor: kColorUtama,
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
            label: 'Invoice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Bayar',
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
        selectedItemColor: const Color(0xFF27B2D1),
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
