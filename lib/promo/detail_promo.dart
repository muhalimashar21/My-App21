import 'package:flutter/material.dart';
import 'package:my_solonet_app/constants.dart';

class DetailPromo extends StatefulWidget {
  final String imagePath; // Accept
  final String title; // Accept
  final String description; // Accept
  final String syaratKetentuan; // Accept

  const DetailPromo({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.syaratKetentuan,
  });

  @override
  _DetailPromoState createState() => _DetailPromoState();
}

class _DetailPromoState extends State<DetailPromo> {
  bool _isExpanded = false; // State untuk dropdown syarat dan ketentuan

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
        backgroundColor: kColorUtama,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imagePath,
                height: 180,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.syaratKetentuan,
                  style: const TextStyle(
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
