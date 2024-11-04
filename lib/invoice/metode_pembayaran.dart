import 'package:flutter/material.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/konfirmasi_pembayaran.dart';

class MetodePembayaran extends StatelessWidget {
  int? _selectedMethod;

  // const MetodePembayaran({super.key});

  final List<Map<String, String>> _paymentMethods = [
    {
      'name': 'Virtual Account BNI',
      'logo': 'assets/images/bni1.png',
    },
    {
      'name': 'Virtual Account BRI',
      'logo': 'assets/images/bri.png',
    },
    {
      'name': 'Transfer BCA',
      'logo': 'assets/images/bca.png',
    },
  ];

  void _selectMethod(int index) {
    setState(() {
      _selectedMethod = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Metode Pembayaran'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_paymentMethods[index]['name']!),
                  leading: Radio<int>(
                    value: index,
                    groupValue: _selectedMethod,
                    onChanged: (value) {
                      if (value != null) {
                        _selectMethod(value);
                      }
                    },
                  ),
                  trailing: Image.asset(
                    _paymentMethods[index]['logo']!,
                    width: 40,
                    height: 40,
                  ),
                );
              },
            ),
          ),
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
                    builder: (context) => KonfirmasiPembayaran(),
                  ),
                );
              },
              child: const Text(
                'Lanjutkan',
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
    );
  }
}

void setState(Null Function() param0) {}
