import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/konfirmasi_pembayaran.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MetodePembayaran extends StatefulWidget {
  @override
  _MetodePembayaranState createState() => _MetodePembayaranState();
}

class _MetodePembayaranState extends State<MetodePembayaran> {
  String? _selectedBank;
  String? token;
  bool _isLoading = false;

  final List<Map<String, String>> _paymentMethods = [
    {
      'name': 'Virtual Account BNI',
      'logo': 'assets/images/bni1.png',
      'bank': 'bni',
    },
    {
      'name': 'Virtual Account BRI',
      'logo': 'assets/images/bri.png',
      'bank': 'bri',
    },
    // {
    //   'name': 'Transfer BCA',
    //   'logo': 'assets/images/bca.png',
    //   'bank': 'bca',
    // },
  ];

  void _selectMethod(String bank) {
    setState(() {
      _selectedBank = bank;
    });
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Pembayaran'),
        content: Text('Apakah Anda yakin ingin melanjutkan pembayaran?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _createVA();
            },
            child: Text('Ya, Lanjutkan'),
          ),
        ],
      ),
    );
  }

  Future<void> _createVA() async {
    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();
    token = await authService.getToken();

    if (token != null && _selectedBank != null) {
      final url = Uri.parse('${baseUrl}api/pembayaran');

      final body = {
        'bank': _selectedBank,
      };

      try {
        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['data'];

          if (data['trx_id'] == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Pembayaran gagal, silakan coba lagi.'),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KonfirmasiPembayaran(
                  trxId: data['trx_id'],
                  bank: _selectedBank!,
                  customerName: data['customer_name'],
                  virtualAccount: data['virtual_account'],
                  trxAmount: data['trx_amount'],
                  description: data['description'],
                  datetimeExpired: data['datetime_expired'],
                  paymentStatus: data['payment_status'],
                  paymentAmount: data['payment_amount'],
                ),
              ),
            );
          }
        } else {
          print('Error: ${response.body}');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }

    setState(() {
      _isLoading = false;
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
                  leading: Radio<String>(
                    value: _paymentMethods[index]['bank']!,
                    groupValue: _selectedBank,
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
              onPressed: _selectedBank != null && !_isLoading
                  ? _showConfirmationDialog
                  : null,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
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
