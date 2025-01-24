import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/metode_pembayaran.dart';
import 'package:my_solonet_app/paket/detail_paket.dart';
import 'package:http/http.dart' as http;

class InvoiceTagihan extends StatefulWidget {
  const InvoiceTagihan({super.key});

  @override
  _InvoiceTagihanState createState() => _InvoiceTagihanState();
}

class _InvoiceTagihanState extends State<InvoiceTagihan> {
  // Define which option is currently active
  String activeOption = 'Internet'; // Default is 'Internet'
  String periode = '';
  String paket = '';
  String totalTagihan = '';
  String tunggakan = '';
  String? token;

  // List of products
  final List<Map<String, String>> products = [
    {'title': 'FO Up To 7 Mbps', 'price': 'Rp 110.000'},
    {'title': 'FO Up To 10 Mbps', 'price': 'Rp 125.000'},
    {'title': 'FO Up To 15 Mbps', 'price': 'Rp 150.000'},
    {'title': 'FO Up To 20 Mbps', 'price': 'Rp 200.000'},
    {'title': 'FO Up To 40 Mbps', 'price': 'Rp 500.000'},
    {'title': 'FO Up To 50 Mbps', 'price': 'Rp 600.000'},
  ];

  get crossAxisAlignment => null; // Timer untuk menggeser halaman

  Future<void> _loadTagihan() async {
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

          // print(data);
          paket = data['paket'];
          periode = data['periode'];
          totalTagihan = formatRupiah(data['total']);
          tunggakan = formatAngka(data['tunggakan']);
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
    _loadTagihan();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Invoice',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: kColorUtama,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Tambahkan margin pada seluruh body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align all items to the start
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const HomeUserBaru(),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorUtama,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text di Tengah
                      Text(
                        ' Tagihan Anda Bulan ' + periode,
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      //Button Bayar Tagihan
                      ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        leading: Image.asset(
                          'assets/images/invoice.jpg',
                          width: 50,
                          height: 50,
                        ),
                        title: Text('Biaya Internet Bulanan \n' + paket,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            )),
                        subtitle: Text(
                            totalTagihan + ' (' + tunggakan + ' Tunggakan) ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                        //Text
                        subtitleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 255, 255, 255)),
                            ),
                            onPressed: () {
                              // Perform some action
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MetodePembayaran(),
                                ),
                              );
                            },
                            child: const Text('Bayar Tagihan Sekarang',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: kColorUtama,
                                )),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 10),
            const Text(
              'Upgrade Paket Internet Anda',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Content Cards
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount:
                      products.length, // Use the length of the product list
                  itemBuilder: (context, index) {
                    return buildCard(
                      products[index]['title']!,
                      products[index]['price']!,
                      context,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build product cards with animated scaling effect on tap
  Widget buildCard(String title, String subtitle, BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke layar detail produk saat card di klik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPaket(
              productTitle: title, // Mengirim judul produk ke layar detail
              keySubtitle: subtitle, // Mengirim harga ke layar detail
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.wifi, size: 36, color: kColorUtama),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, size: 24, color: kColorUtama),
            ],
          ),
        ),
      ),
    );
  }
}
