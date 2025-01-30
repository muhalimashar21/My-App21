import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:http/http.dart' as http;

class HomeInvoice extends StatefulWidget {
  const HomeInvoice({super.key});

  @override
  State<HomeInvoice> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeInvoice> {
  get crossAxisAlignment => null; // Timer untuk menggeser halaman
  String idRegister = '';
  String nama = '';
  String email = '';
  String telp = '';
  String alamat = '';
  String paket = '';
  String harga = '';
  String? token;
  String tunggakan = '';
  String totalTagihan = '';
  String periode = '';

  Future<void> _loadUserTagihan() async {
    final authService = AuthService();
    token = await authService.getToken();

    if (token != null) {
      final url = Uri.parse('https://mysolonet.connectis.my.id/api/tagihan');

      try {
        final response = await http.get(url, headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // print(data);
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
    _loadUserTagihan();
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
                          'Sebesar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          totalTagihan,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //text bayar tagihan
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // bayar ke halaman pembayaran
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => HomeInvoice()));
                        //   },
                        //   child: Text('Bayar Tagihan Sekarang'),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
