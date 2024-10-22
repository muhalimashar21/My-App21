import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:my_solonet_app/auth/login.dart';
import 'package:my_solonet_app/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _whatsappController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future<void> _createUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context)
                  .unfocus(); // Menutup keyboard saat klik di luar TextField
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo1.png",
                        height: 100,
                        width: 180,
                      ),
                      SizedBox(height: constraints.maxHeight * 0.025),
                      const Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildLabel('Nama Lengkap'),
                            _buildTextField(
                                _fullnameController,
                                'Masukkan Nama Lengkap',
                                TextInputType.text, (value) {
                              if (value!.isEmpty) {
                                return "Nama lengkap tidak boleh kosong";
                              }
                              return null;
                            }),
                            const SizedBox(height: 16.0),
                            _buildLabel('Email'),
                            _buildTextField(
                                _emailController,
                                'Masukkan Email Anda',
                                TextInputType.emailAddress, (value) {
                              if (value!.isEmpty) {
                                return "Email tidak boleh kosong";
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Email tidak valid";
                              }
                              return null;
                            }),
                            const SizedBox(height: 16.0),
                            _buildLabel('Whatsapp'),
                            _buildWhatsappTextField(),
                            const SizedBox(height: 16.0),
                            // _buildLabel('Address'),
                            // _buildTextField(
                            //     _addressController,
                            //     'Enter Your Address',
                            //     TextInputType.text, (value) {
                            //   if (value!.isEmpty) {
                            //     return "Address cannot be empty";
                            //   }
                            //   return null;
                            // }),
                            // const SizedBox(height: 16.0),
                            _buildLabel('Password'),
                            _buildPasswordField(
                                _passwordController, 'Masukkan Password',
                                (value) {
                              if (value!.isEmpty) {
                                return "Password tidak boleh kosong";
                              }
                              if (value.length < 6) {
                                return "Password harus lebih dari 6 karakter";
                              }
                              return null;
                            }),
                            const SizedBox(height: 16.0),
                            _buildLabel('Konfirmasi Password'),
                            _buildPasswordField(_confirmpasswordController,
                                'Masukkan Konfirmasi Password', (value) {
                              if (value!.isEmpty) {
                                return "Konfirmasi password tidak boleh kosong";
                              }
                              if (value != _passwordController.text) {
                                return "Password tidak cocok";
                              }
                              return null;
                            }),
                            const SizedBox(height: 16.0),
                            _buildRegisterButton(context),
                            _buildSignInLink(context),
                            const SizedBox(height: 16.0),
                            const Text(
                              "or",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.5,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            _buildGoogleSignUpButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Padding _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField(TextEditingController controller, String hint,
      TextInputType type, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: Colors.grey, fontFamily: 'Poppins', fontSize: 13.5),
        filled: true,
        fillColor: const Color(0xFFF5FCF9),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12.0,
          fontFamily: 'Poppins',
        ),
      ),
      keyboardType: type,
      validator: validator,
    );
  }

  TextFormField _buildWhatsappTextField() {
    return TextFormField(
      controller: _whatsappController,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color(0xFFF5FCF9),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 12.0,
          fontFamily: 'Poppins',
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12.0, right: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "+62",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8.0),
              Text(
                "|",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return "Whatsapp number cannot be empty";
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(15),
      ],
    );
  }

  TextFormField _buildPasswordField(TextEditingController controller,
      String hint, String? Function(String?)? validator) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: Colors.grey, fontFamily: 'Poppins', fontSize: 13.5),
        filled: true,
        fillColor: const Color(0xFFF5FCF9),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12.0,
          fontFamily: 'Poppins',
        ),
      ),
      validator: validator,
    );
  }

  ElevatedButton _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          _createUser(context);
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: kColorUtama,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: const StadiumBorder(),
      ),
      child: Text(
        _isLoading ? "Loading..." : "Daftar",
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Align _buildSignInLink(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          );
        },
        child: const Text.rich(
          TextSpan(
            text: "Sudah punya akun? ",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: "Masuk Sekarang",
                style: TextStyle(
                  color: kColorUtama,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlinedButton _buildGoogleSignUpButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset(
        "assets/images/google.png",
        width: 18,
        height: 18,
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: const StadiumBorder(),
      ),
      label: const Text(
        "Masuk dengan Google",
        style: TextStyle(fontSize: 14.5, fontFamily: 'Poppins'),
      ),
    );
  }
}
