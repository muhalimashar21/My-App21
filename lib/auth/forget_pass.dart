import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_solonet_app/auth/otp.dart';
import 'dart:convert';

import 'package:my_solonet_app/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "",
          style: TextStyle(color: Color(0xFF757575), fontFamily: 'Poppins'),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo1.png',
                    width: 150,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Masukkan WA",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  // const Text(
                  //   "Please enter your number WhatsApp and we will \nsend you a link to return to your account",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontFamily: 'Poppins',
                  //     color: Color(0xFF757575),
                  //   ),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  _ForgotPasswordForm(
                    formKey: _formKey,
                    controller: _phoneController,
                    isLoading: _isLoading,
                    onSubmit: _submitForm,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  // const _NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSubmit;

  const _ForgotPasswordForm({
    required this.formKey,
    required this.controller,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Masukkan nomor WhatsApp",
                    labelText: "WhatsApp",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: const TextStyle(
                      color: Color(0xFF757575),
                      fontFamily: 'Poppins',
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "+62",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            "|",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    border: _authOutlineInputBorder,
                    enabledBorder: _authOutlineInputBorder,
                    focusedBorder: _authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OtpWA(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: kColorUtama,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: Text(
              isLoading ? "Loading..." : "Daftar",
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }
}

const _authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);
