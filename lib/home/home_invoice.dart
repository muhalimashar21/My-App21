import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:http/http.dart' as http;

class HomeInvoice extends StatefulWidget {
  const HomeInvoice({super.key});

  @override
  State<HomeInvoice> createState() => _HomeInvoiceState();
}

class _HomeInvoiceState extends State<HomeInvoice> {
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
          setState(() {
            paket = data['paket'] ?? '';
            periode = data['periode'] ?? '';
            totalTagihan = formatRupiah(data['total'] ?? 0);
            tunggakan = formatAngka(data['tunggakan'] ?? 0);
          });
        } else {
          print('Error: ${response.body}');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserTagihan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Invoice',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: kColorUtama,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              color: tunggakan == '0' ? Colors.grey.shade300 : kColorUtama,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (tunggakan == '0') ...[
                              const Icon(
                                Icons.wifi_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                              const SizedBox(height: 2),
                            ],
                            Text(
                              tunggakan == '0'
                                  ? 'Anda tidak memiliki tagihan'
                                  : 'Anda Punya $tunggakan Tagihan',
                              style: TextStyle(
                                color: tunggakan == '0' ? Colors.black : Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            if (tunggakan != '0') ...[
                              Text(
                                'Bulan $periode',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              const Text(
                                'Sebesar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                totalTagihan,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    if (tunggakan == '0')
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 28,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
