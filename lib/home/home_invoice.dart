import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:my_solonet_app/invoice/metode_pembayaran.dart';

class HomeInvoice extends StatefulWidget {
  const HomeInvoice({super.key});

  @override
  State<HomeInvoice> createState() => _HomeInvoiceState();
}

class _HomeInvoiceState extends State<HomeInvoice> {
  get crossAxisAlignment => null; // Timer untuk menggeser halaman

  String paket = '';
  String tunggakan = '';
  String totalTagihan = '';
  String periode = '';
  String? token;
  List<dynamic> _products = [];

  Future<void> _loadUserData() async {
    final authService = AuthService();
    token = await authService.getToken();

    if (token != null) {
      final url = Uri.parse('${baseUrl}api/tagihan');

      try {
        final response = await http.get(url, headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          print(data);
          setState(() {
            paket = data['paket'];
            periode = data['periode'];
            totalTagihan = formatRupiah(data['total']);
            tunggakan = formatAngka(data['tunggakan']);
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
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg"), // Placeholder image
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Anda Punya ' + tunggakan + ' Tagihan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Bulan ' + periode,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          paket,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          totalTagihan,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0),
            //button bayar
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MetodePembayaran(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Bayar Tagihan Sekarang',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
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
