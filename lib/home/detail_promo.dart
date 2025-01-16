import 'package:flutter/material.dart';

class DetailPromo extends StatefulWidget {
  final String title;
  final String description;

  const DetailPromo(
      {super.key, required this.title, required this.description});

  @override
  State<DetailPromo> createState() => _DetailPromoState();
}

class _DetailPromoState extends State<DetailPromo> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Promo',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                widget.description,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Syarat dan Ketentuan',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(_isExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            if (_isExpanded)
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '1. Paket berlaku untuk pengguna baru.\n'
                  '2. Pembayaran harus dilakukan sebelum akhir bulan.\n'
                  '3. Tidak dapat digabung dengan promo lainnya.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
