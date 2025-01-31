import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/invoice/view_berhasil_bayar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KonfirmasiPembayaran extends StatefulWidget {
  final String trxId;
  final String bank;
  final String customerName;
  final String virtualAccount;
  final String datetimeExpired;
  final String trxAmount;
  final String description;
  final String paymentStatus;
  final dynamic paymentAmount;

  const KonfirmasiPembayaran({
    super.key,
    required this.trxId,
    required this.bank,
    required this.customerName,
    required this.virtualAccount,
    required this.datetimeExpired,
    required this.trxAmount,
    required this.description,
    required this.paymentStatus,
    required this.paymentAmount,
  });

  @override
  _KonfirmasiPembayaranState createState() => _KonfirmasiPembayaranState();
}

class _KonfirmasiPembayaranState extends State<KonfirmasiPembayaran> {
  bool _isLoading = false;
  String? token;

  Future<void> _checkPaid() async {
    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();
    token = await authService.getToken();

    if (token != null) {
      final url = Uri.parse('${baseUrl}api/status-pembayaran');
      final body = {
        'bank': widget.bank,
        'trx_id': widget.trxId,
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
          final data = json.decode(response.body);

          if (data['payment_status'] == 'paid') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewBerhasilBayar(),
              ),
            );
          } else {
            _showAlert('Status Pembayaran', 'Status pembayaran: ${data['payment_status']}');
          }
        } else {
          _showAlert('Error', 'Terjadi kesalahan: ${response.body}');
        }
      } catch (e) {
        _showAlert('Error', 'Gagal memeriksa pembayaran: $e');
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terima kasih telah melakukan pemesanan!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Ringkasan Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Nama Pelanggan: ${widget.customerName}'),
            Text('Deskripsi: ${widget.description}'),
            Text('Nominal: Rp ${widget.trxAmount}'),
            const SizedBox(height: 10),
            const Divider(),
            const Text(
              'Detail Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Status: ${widget.paymentStatus}'),
            Text('Nominal Dibayar: Rp ${widget.paymentAmount}'),
            const SizedBox(height: 10),
            const Divider(),
            const Text(
              'Metode Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Virtual Account: ${widget.virtualAccount}'),
            const SizedBox(height: 20),
            const Text(
              'Batas Waktu Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Kadaluarsa: ${widget.datetimeExpired}'),
            const SizedBox(height: 150),
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
                onPressed: _isLoading ? null : _checkPaid,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Cek Pembayaran',
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
