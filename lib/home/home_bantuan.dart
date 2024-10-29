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
          style: TextStyle(color: Colors.white),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ExpansionTile(
                    title: Text('Apa itu Flutter?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Flutter adalah framework open-source yang dikembangkan oleh Google untuk membangun aplikasi mobile, web, dan desktop dari satu basis kode.',
                        ),
                      ),
                    ],
                  ),
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
                    title: Text('Bagaimana cara menginstal Flutter?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Anda dapat menginstal Flutter dengan mengikuti petunjuk di situs resmi Flutter di https://flutter.dev/docs/get-started/install.',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                        'Apa perbedaan antara Stateful dan Stateless Widget?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Stateful Widget dapat mengubah keadaan (state) selama siklus hidupnya, sedangkan Stateless Widget tidak dapat mengubah keadaan setelah dibangun.',
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ceritakan kendalamu lewat chat',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Aksi untuk memulai chat
                      },
                      icon: Icon(Icons.headset),
                      label: Text('Mulai Chat'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Atau hubungi kami lewat',
                    style: TextStyle(fontSize: 15),
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
                                  style: TextStyle(fontSize: 18),
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
                                  style: TextStyle(fontSize: 18),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jl. Arifin No.129, Kepatihan Kulon, Kec. Jebres, Kota Surakarta, Jawa Tengah 57129',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Aksi untuk membuka peta
                      },
                      icon: Icon(Icons.map),
                      label: Text('Lihat di Peta'),
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
