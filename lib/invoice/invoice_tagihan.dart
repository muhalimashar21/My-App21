import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/metode_pembayaran.dart';
import 'package:my_solonet_app/paket/detail_paket.dart';
import 'package:my_solonet_app/promo/detail_promo.dart';

class InvoiceTagihan extends StatefulWidget {
  const InvoiceTagihan({super.key});

  @override
  _InvoiceTagihanState createState() => _InvoiceTagihanState();
}

class _InvoiceTagihanState extends State<InvoiceTagihan> {
  // Define which option is currently active
  String activeOption = 'Internet'; // Default is 'Internet'

  // List of products
  final List<Map<String, String>> products = [
    {'title': 'FO Up To 7 Mbps', 'price': 'Rp 110.000'},
    {'title': 'FO Up To 10 Mbps', 'price': 'Rp 125.000'},
    {'title': 'FO Up To 15 Mbps', 'price': 'Rp 150.000'},
    {'title': 'FO Up To 20 Mbps', 'price': 'Rp 200.000'},
    {'title': 'FO Up To 40 Mbps', 'price': 'Rp 500.000'},
    {'title': 'FO Up To 50 Mbps', 'price': 'Rp 600.000'},
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0; // Menyimpan halaman yang sedang ditampilkan
  late Timer _timer;

  get crossAxisAlignment => null; // Timer untuk menggeser halaman

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        Future.delayed(const Duration(seconds: 0), () {
          _currentPage = 0;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOutCubic,
          );
        });
        return;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Upgrade',
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
            const SizedBox(height: 10),

            SizedBox(
              height: 157.5,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 5,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  // Determine the image based on the index
                  String imagePath;
                  if (index == 0 || index == 2 || index == 4) {
                    imagePath = 'assets/images/PromoPasang.png';
                  } else {
                    imagePath = 'assets/images/Promoalat.png';
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPromo(
                            imagePath:
                                imagePath, // Pass imagePath to DetailPromoScreen
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 280, // Lebar kontainer
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath, // Display the appropriate image based on the index
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
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
                        '   Tagihan Anda',
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
                        title: Text('Biaya Internet Bulanan \n (UP TO 7 Mbps)',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            )),
                        subtitle: Text('Rp 150.000',
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
