import 'package:flutter/material.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/histori_pembayaran.dart';
import 'package:my_solonet_app/invoice/metode_pembayaran.dart';

class BayarInvoice extends StatefulWidget {
  const BayarInvoice({super.key});

  @override
  State<BayarInvoice> createState() => _BayarInvoiceState();
}

class _BayarInvoiceState extends State<BayarInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bayar Invoice',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: kColorUtama,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        // Wrapping the body with ScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Info Card
            Card(
              elevation: 4,
              color: kColorUtama,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.payment,
                        color: kColorUtama,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //text bayar tagihan
                        ElevatedButton(
                          onPressed: () {
                            // bayar ke halaman pembayaran
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MetodePembayaran()));
                          },
                          child: Row(
                            children: [
                              const Text(
                                'Bayar Invoice Sekarang',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            Card(
              elevation: 4,
              color: kColorUtama,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.payment,
                        color: kColorUtama,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //text bayar tagihan
                        ElevatedButton(
                          onPressed: () {
                            // bayar ke halaman pembayaran
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoriPembayaran()));
                          },
                          child: Row(
                            children: [
                              const Text(
                                'Cek Histori Pembayaran',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        )
                      ],
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
