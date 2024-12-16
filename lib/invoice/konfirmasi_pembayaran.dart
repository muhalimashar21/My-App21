import 'package:flutter/material.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/view_berhasil_bayar.dart';

class KonfirmasiPembayaran extends StatelessWidget {
  const KonfirmasiPembayaran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terima kasih telah melakukan pemesanan!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Ringkasan Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Paket Internet:'),
            Text('Nama Paket: FO Up To 7 Mbps'),
            Text('Kecepatan: 100 Mbps'),
            Text('Durasi: 1 Bulan'),
            SizedBox(height: 10),
            Text('Rincian Biaya:'),
            Text('Biaya Bulanan: Rp 300.000'),
            Text('Biaya Administrasi: Rp 20.000'),
            SizedBox(height: 10),
            Divider(),
            Text(
              'Total Nominal: Rp 320.000',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Metode Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Transfer Bank: BCA'),
            Text('No. Rekening: 1234567890'),
            SizedBox(height: 20),
            Text(
              'Batas Waktu Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Tanggal: 10 November 2024'),
            SizedBox(height: 150),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kColorUtama,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewBerhasilBayar(),
                    ),
                  );
                },
                child: const Text(
                  'Bayar Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
