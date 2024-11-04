import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/login.dart';
import 'package:my_solonet_app/home/home_pilihan_user.dart';
import 'package:my_solonet_app/promo/detail_promo.dart';

class HomeUserBaru extends StatefulWidget {
  const HomeUserBaru({super.key});

  @override
  State<HomeUserBaru> createState() => _HomeUserBaruState();
}

class _HomeUserBaruState extends State<HomeUserBaru> {
  get crossAxisAlignment => null; // Timer untuk menggeser halaman

  final PageController _pageController = PageController();
  int _currentPage = 0; // Menyimpan halaman yang sedang ditampilkan
  late Timer _timer;

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
