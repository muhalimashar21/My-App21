import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/home/promo_section.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeUserBaru extends StatefulWidget {
  const HomeUserBaru({super.key});

  @override
  State<HomeUserBaru> createState() => _HomeUserBaruState();
}

class _HomeUserBaruState extends State<HomeUserBaru> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier =
      ValueNotifier<int>(0); // Tambahkan ValueNotifier
  List<dynamic> _banners = [];
  int _currentPage = 0; // Menyimpan halaman yang sedang ditampilkan
  late Timer _timer;
  String? token;

  Future<void> _fetchBanners() async {
    final authService = AuthService();
    token = await authService.getToken();

    final url = Uri.parse('${baseUrl2}banner');

    try {
      final response = await http.get(url, headers: {
        // 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // print(data);

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
  void initState() {
    super.initState();
    _fetchBanners();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _currentPageNotifier.dispose(); // Pastikan ValueNotifier dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Yuk Gabung',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 157.5,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const HomePilihanUser(),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27B2D1),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Berlanggan di Solonet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )),
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

            const SizedBox(height: 10),

            const Text(
              'Special For You',
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
            const SizedBox(height: 20),
            const Text(
              'Area Tercover',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            //show maps in here maps.png
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/images/maps.png'),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
