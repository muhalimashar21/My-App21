import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/histori_pembayaran.dart';
import 'package:http/http.dart' as http;

class HomeProfile extends StatefulWidget {
  const HomeProfile({super.key});

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  get crossAxisAlignment => null; // Timer untuk menggeser halaman
  String idRegister = '';
  String nama = '';
  String email = '';
  String telp = '';
  String alamat = '';
  String paket = '';
  String harga = '';
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

          // print(data);
          setState(() {
            idRegister = data['id_register'];
            nama = data['nama'];
            email = data['email'];
            telp = data['telp'];
            alamat = data['alamat'];
            paket = data['paket']['nama'];
            harga = formatRupiah(data['paket']['harga']);
          });
        } else {
          print('Error: ${response.body}');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  String _profileText(String nama) {
    List<String> words = nama.split(' ');
    return words.isNotEmpty ? words[0] : '';
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invoice',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: kColorUtama,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        // Wrapping the body with ScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Info Card
            Card(
              elevation: 4,
              color: kColorUtama,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg"), // Placeholder image
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // User Information Card with Icons
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Information',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInfoRow(Icons.person, 'User ID: \n' + idRegister),
                    _buildInfoRow(Icons.home, 'Alamat: \n' + alamat), // Alamat
                    _buildInfoRow(Icons.phone, 'Telp / WA: \n' + telp), // Telp
                    _buildInfoRow(Icons.network_wifi,
                        'Paket Internet: \n' + paket + ' \n' + harga), // Paket
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Settings Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('History Pembayaran'),
                      trailing: Icon(
                        Icons.payment,
                        color: kColorUtama,
                      ),
                      onTap: () {
                        // History Pembayaran action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoriPembayaran(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Edit Profile'),
                      trailing: Icon(
                        Icons.edit,
                        color: kColorUtama,
                      ),
                      onTap: () {
                        // Edit profile action
                      },
                    ),
                    ListTile(
                      title: Text('Change Password'),
                      trailing: Icon(
                        Icons.lock,
                        color: kColorUtama,
                      ),
                      onTap: () {
                        // Change password action
                      },
                    ),
                    ListTile(
                      title: Text('Logout'),
                      trailing: Icon(
                        Icons.logout,
                        color: kColorUtama,
                      ),
                      onTap: () {
                        // Logout action
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32), // Space before the version text

            // Version Number
            Text(
              'Version 1.0.0', // Replace with your version
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey, // Grey color for the version text
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build info rows with icons
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: kColorUtama), // Icon color
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
