import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/login.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/home/home_page_content.dart';
import 'package:my_solonet_app/home/home_screen.dart';
import 'package:my_solonet_app/home/home_user_baru.dart';
import 'package:my_solonet_app/main.dart';

class HomePilihanUser extends StatefulWidget {
  const HomePilihanUser({super.key});

  @override
  State<HomePilihanUser> createState() => _HomePilihanUserState();
}

class _HomePilihanUserState extends State<HomePilihanUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pilih Menu Di Bawah Sini'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorUtama,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.accessibility,
                        size: 40, color: Colors.white),
                    title: Text(
                      'Sudah Jadi Pelanggan Solonet',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeUserBaru(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorUtama,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.production_quantity_limits_outlined,
                        size: 40, color: Colors.white),
                    title: Text(
                      'Promo, Coverage, Produk',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePageContent(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorUtama,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.home, size: 40, color: Colors.white),
                    title: Text(
                      'Mengapa Solonet?',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
