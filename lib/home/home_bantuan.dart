import 'package:flutter/material.dart';
import 'package:my_solonet_app/constants.dart';

class HomeBantuan extends StatefulWidget {
  const HomeBantuan({super.key});

  @override
  State<HomeBantuan> createState() => _HomeBantuanState();
}

class _HomeBantuanState extends State<HomeBantuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: kColorUtama,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian FAQ
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paling Sering Ditanyakan (FAQ)',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ExpansionTile(
                    title: Text('Apa itu Solonet?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Solonet adalah aplikasi yang memungkinkan Anda untuk membeli paket data internet, pulsa, token listrik, dan lainnya secara online.',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Apa aja Layanan di Solonet?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Kami memiliki 3 layanan utama: IT Infrastruktur, Jaringan Internet, Web Hosting.',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Apa aja Paket Internet yang ada di Solonet?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Paket Solonet kami ada paket Home 1 Up To 3 Mbps, Home 2 Up To 4 Mbps, dan Home 3 Up To 5 Mbps.',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Jika ada Kendala Bagaimana Solusinya?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Kami memiliki layanan Customer Care 24 Jam yang siap membantu Anda. Anda bisa menghubungi kami melalui chat atau telepon dibawah ini.',
                        ),
                      ),
                    ],
                  ), // Tambahkan lebih banyak FAQ sesuai kebutuhan
                ],
              ),
            ),

            // Bagian Layanan Pelanggan
            Container(
              color: Colors.blue[100], // Background biru muda
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Layanan Customer Care 24 Jam',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ceritakan kendalamu lewat chat',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Aksi untuk memulai chat
                      },
                      icon: Icon(Icons.headset),
                      label: Text('Mulai Chat',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          )),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Atau hubungi kami lewat',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.phone, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  'Telepon',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20), // Spasi antara kartu
                      Expanded(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.email, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Card untuk lokasi kantor
            Card(
              elevation: 1,
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'Lokasi Kantor Kami',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jl. Arifin No.129, Kepatihan Kulon, Kec. Jebres, Kota Surakarta, Jawa Tengah 57129',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Aksi untuk membuka peta
                      },
                      icon: Icon(Icons.map),
                      label: Text('Lihat di Peta',
                          style:
                              TextStyle(fontSize: 16, fontFamily: 'Poppins')),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
