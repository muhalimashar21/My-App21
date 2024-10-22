import 'package:flutter/material.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:my_solonet_app/home/home_screen.dart';

class OtpWA extends StatefulWidget {
  const OtpWA({super.key});

  @override
  State<OtpWA> createState() => _OtpWAState();
}

class _OtpWAState extends State<OtpWA> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool _isLoading = false;
  bool _isResendOtp = false;
  bool _isLoadingResend = false;
  int _start = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          height: 56.0,
          color: Colors.transparent,
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo1.png',
                width: 150,
                height: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              // const Text(
              //   "Verifikasi Kode OTP",
              //   style: TextStyle(
              //     fontFamily: 'Poppins',
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Color(0xFF333333),
              //   ),
              // ),
              const SizedBox(height: 10),
              const Text(
                "Silakan masukkan kode 6 digit OTP yang telah dikirimkan melalui nomor Whatsapp anda",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => Container(
                    width: 35,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        } else {
                          if (index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        }
                        if (_isOtpComplete()) {
                          // Jika semua field terisi, maka lakukan sesuatu
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  _isLoading ? 'Loading...' : 'Verifikasi',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Belum menerima kode?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _isResendOtp
                    ? 'Minta kode baru sekarang'
                    : 'Minta kode baru dalam 00:${_start.toString().padLeft(2, '0')} detik',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: _isResendOtp ? Colors.blue : const Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 10),
              if (_isResendOtp)
                ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    _isLoadingResend ? "Loading..." : "Resend OTP",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isOtpComplete() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true; // Jika semua field terisi, kembalikan true
  }
}

_buildOtpField(int index) {}
