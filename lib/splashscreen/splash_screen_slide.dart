import 'package:flutter/material.dart';
import 'package:my_solonet_app/splashscreen/slide_page.dart';
import 'package:my_solonet_app/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreenSlide extends StatefulWidget {
  const SplashScreenSlide({super.key});

  @override
  State<SplashScreenSlide> createState() => _SplashScreenSlideState();
}

class _SplashScreenSlideState extends State<SplashScreenSlide> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    // No need to call _checkFirstLaunch() here
  }

  Future<void> _markNotFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PageView untuk menampilkan slides
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            children: const [
              SlidePage(
                imagePath:
                    'assets/images/splash_screen1.png', // Update sesuai path
                title: 'Kecepatan Tinggi, \n Akses Tanpa Batas',
                description:
                    'Langganan internet di solonet dengan \n kecepatan tinggi dan akses tanpa batas',
              ),
              SlidePage(
                imagePath: 'assets/images/splash_screen2.png',
                title: 'Support 24 per 7 hari',
                description:
                    'Jika ada kendala Solonet siap \n membantumu 24 jam',
              ),
              SlidePage(
                imagePath: 'assets/images/splash_screen3.png',
                title: 'Harga Terjangkau',
                description:
                    'Berlangganan di Solonet harga \n murah dan terjangkau',
              ),
            ],
          ),
          // Indikator posisi halaman dan tombol di bagian bawah
          Positioned(
            bottom: 50,
            left: 45,
            right: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Page Indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 8.0,
                  ),
                ),
                // Tombol untuk pindah ke SignInScreen hanya di slide terakhir
                ElevatedButton(
                  onPressed: () async {
                    await _markNotFirstLaunch(); // Mark as not first launch
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(6),
                  ),
                  child: Icon(Icons.keyboard_arrow_right_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
