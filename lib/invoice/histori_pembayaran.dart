import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/detail_histori_pembayaran.dart';

class HistoriPembayaran extends StatefulWidget {
  const HistoriPembayaran({super.key});

  @override
  State<HistoriPembayaran> createState() => _HistoriPembayaranState();
}

class _HistoriPembayaranState extends State<HistoriPembayaran> {
  // Define which option is currently active
  String activeOption = 'Internet'; // Default is 'Internet'

  // List of products
  final List<Map<String, String>> products = [
    {"title": "15 Januari 2024", "price": "Rp150.000"},
    {"title": "01 Februari 2024", "price": "Rp150.000"},
    {"title": "10 Maret 2024", "price": "Rp150.000"},
    {"title": "01 April 2024", "price": "Rp150.000"},
    {"title": "11 Mei 2024", "price": "Rp150.000"},
    {"title": "04 Juni 2024", "price": "Rp150.000"},
    {"title": "12 Juli 2024", "price": "Rp150.000"},
    {"title": "03 Agustus 2024", "price": "Rp150.000"},
  ];

  get crossAxisAlignment => null; // Timer untuk menggeser halaman

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Histori Pembayaran',
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
            const SizedBox(height: 7),

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

  // Widget to build the selectable options
  Widget buildOption(String option) {
    bool isActive = activeOption == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          activeOption = option;
        });
      },
      child: Column(
        children: [
          Text(
            option,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: isActive
                  ? Colors.blue
                  : Colors.grey, // Active is blue, inactive is grey
              fontWeight: isActive
                  ? FontWeight.w500
                  : FontWeight.w400, // Bold if active
            ),
          ),
          if (isActive)
            Align(
              alignment: Alignment.center, // Align the line to the center
              child: Container(
                margin: const EdgeInsets.only(top: 5), // Spacing for underline
                height: 2,
                width: 60, // Width of the underline
                color: Colors.blue, // Blue underline for active
              ),
            ),
        ],
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
            builder: (context) => DetailHistoriPembayaran(
              productTitle: title, // Mengirim judul produk ke layar detail
              keySubtitle: subtitle,
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
                  const Icon(Icons.payment, size: 36, color: kColorUtama),
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
