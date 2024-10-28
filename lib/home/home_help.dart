import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_solonet_app/auth/login.dart';
import 'package:my_solonet_app/auth/otp.dart';
import 'package:my_solonet_app/auth/register.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/home/home_user_baru.dart';
import 'package:my_solonet_app/splashscreen/splash_screen_slide.dart';
import 'package:my_solonet_app/splashscreen/splashscreen.dart';

class HomeHelp extends StatefulWidget {
  const HomeHelp({super.key});

  @override
  State<HomeHelp> createState() => _HomeHelpState();
}

class _HomeHelpState extends State<HomeHelp> {
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
    var foregroundColor;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Kamu mengalami kendala?',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),
            //Layanan Customer Service 24 Jam
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
                      const Text(
                        'Customer Service 24 Jam',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Hubungi kami kapan saja',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Button Hubungi Customer Service
                      TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(290, 40)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 255, 255)),
                        ),
                        onPressed: () {},
                        child: const Text('Mulai Chat',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: kColorUtama,
                            )),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            //Produk dan Layanan Kami
            const Text(
              'Lokasi Kantor Solonet',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              'Butuh bantuan secara langsung?',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Text(
              'Kunjungi Kantor Solonet terdekat',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Text(
              'dari tempatmu',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(320, 40)),
                backgroundColor: MaterialStateProperty.all<Color>(kColorUtama),
                foregroundColor: MaterialStateProperty.all<Color>(kColorUtama),
              ),
              onPressed: () {},
              child: const Text('Lihat Lokasi',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 20),

            //Lokasi Kantor Solonet Terdekat beserta Peta dan logo peta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
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
                      const Text(
                        'Produk dan Layanan Kami',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Temukan lebih banyak informasi dan tips',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'seputar produk Solonet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Button Temukan Lokasi Kantor
                      TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(290, 40)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 255, 255)),
                        ),
                        onPressed: () {},
                        child: const Text('Info Produk',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: kColorUtama,
                            )),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )),
            ),

            const SizedBox(height: 20),

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
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => DetailPromoScreen(
                    //         imagePath: imagePath, // Pass imagePath to DetailPromoScreen
                    //       ),
                    //     ),
                    //   );
                    // },
                    child: Container(
                      width: 280, // Lebar kontainer
                      margin: const EdgeInsets.symmetric(horizontal: 5),
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
          ],
        ),
      ),
    );
  }
}
