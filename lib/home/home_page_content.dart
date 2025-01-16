import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_solonet_app/auth/login.dart';
import 'package:my_solonet_app/auth/otp.dart';
import 'package:my_solonet_app/auth/register.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/home/home_user_baru.dart';
import 'package:my_solonet_app/home/promo_section.dart';
import 'package:my_solonet_app/promo/detail_promo.dart';
import 'package:my_solonet_app/splashscreen/splash_screen_slide.dart';
import 'package:my_solonet_app/splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier =
      ValueNotifier<int>(0); // Tambahkan ValueNotifier
  List<dynamic> _banners = [];
  int _currentPage = 0; // Menyimpan halaman yang sedang ditampilkan
  late Timer _timer;
  String? token;

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

  Future<void> _fetchBanners() async {
    final authService = AuthService();
    token = await authService.getToken();

    final url = Uri.parse('${baseUrl}api/promo');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _banners = data;
        });

        if (_banners.isNotEmpty) {
          _startBannerTimer();
        }
      } else {
        throw Exception('Failed to fetch banners');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _startBannerTimer() {
    if (_banners.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        final nextPage = (_currentPageNotifier.value + 1) % _banners.length;
        _currentPageNotifier.value = nextPage;

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeInOutCubic,
        );
      });
    }
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
          title: Text(
            'Invoice',
            style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
          backgroundColor: kColorUtama,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Promo',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // Gunakan ValueListenableBuilder untuk hanya memperbarui PromoSection
                ValueListenableBuilder<int>(
                  valueListenable: _currentPageNotifier,
                  builder: (context, currentPage, _) {
                    return PromoSection(
                      banners: _banners,
                      pageController: _pageController,
                      currentPage: currentPage,
                      onPageChanged: (index) {
                        _currentPageNotifier.value = index;
                      },
                    );
                  },
                ),
                // SizedBox(
                //   height: 157.5,
                //   child: PageView.builder(
                //     controller: _pageController,
                //     itemCount: 5,
                //     onPageChanged: (index) {
                //       setState(() {
                //         _currentPage = index;
                //       });
                //     },
                //     itemBuilder: (context, index) {
                //       // Determine the image based on the index
                //       String imagePath;
                //       if (index == 0 || index == 2 || index == 4) {
                //         imagePath = 'assets/images/PromoPasang.png';
                //       } else {
                //         imagePath = 'assets/images/Promoalat.png';
                //       }

                //       return GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => DetailPromo(
                //                 imagePath:
                //                     imagePath, // Pass imagePath to DetailPromoScreen
                //               ),
                //             ),
                //           );
                //         },
                //         child: Container(
                //           width: 280, // Lebar kontainer
                //           margin: const EdgeInsets.symmetric(horizontal: 5),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(10),
                //             child: Image.asset(
                //               imagePath, // Display the appropriate image based on the index
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
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
                          const Text(
                            'Tagihan',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Rp 150.000',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Januari - Februari 2024',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          //Button Bayar Tagihan
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 255, 255, 255)),
                            ),
                            onPressed: () {},
                            child: const Text('Bayar Tagihan Sekarang',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: kColorUtama,
                                )),
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Upgrade Paket Internet Anda Sekarang',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 3, bottom: 3),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5.0,
                          shadowColor: Colors.black38,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(6.5, 6.5, 6.5, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/Promoalat.png',
                                        height: 80,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(7, 7, 7, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Up to 3 Mbps',
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontFamily: 'Poppins',
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      'Category',
                                      style: TextStyle(
                                        fontSize: 6.5,
                                        fontFamily: 'Poppins',
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Rp 150.000',
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontFamily: 'Poppins',
                                        color: Color.fromARGB(255, 34, 50, 64),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
