import 'package:flutter/material.dart';
import 'package:my_solonet_app/alert/show_message_failed.dart';
import 'package:my_solonet_app/alert/show_message_success.dart';
import 'dart:convert';

import 'package:my_solonet_app/auth/forget_pass.dart';
import 'package:my_solonet_app/auth/register.dart';
import 'package:my_solonet_app/auth/service/service.dart';
import 'package:my_solonet_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:my_solonet_app/home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool isPasswordVisible = false;

  Future<void> _loginUser(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final authService = AuthService();

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse("${baseUrl}api/login");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    final body = json.encode({
      "username": _usernameController.text,
      "password": _passwordController.text,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['access_token'];
        await authService.saveToken(token);
        showSuccessMessage(context, 'Login success');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        final responseData = json.decode(response.body);
        showFailedMessage(context, responseData['error']);
      }
    } catch (e) {
      showFailedMessage(context, 'Gagal Login: $e');
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Image.asset(
                      "assets/images/logo1.png",
                      height: 100,
                      width: 180,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    const Text(
                      "Login",
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
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Masukkan Username',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14.5,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              hintText: 'ID User',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                                fontSize: 13.5,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF5FCF9),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Masukkan Password',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14.5,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                                fontSize: 13.5,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF5FCF9),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 10.0),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()),
                                );
                              },
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: kColorUtama,
                                ),
                              ),
                            ),
                          ),
                          // Sign In Link moved above Login button
                          _buildSignUpLink(context),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _loginUser(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: kColorUtama,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                              shape: const StadiumBorder(),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Masuk",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
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
      ),
    );
  }
}

Align _buildSignUpLink(BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      },
      child: const Text.rich(
        TextSpan(
          text: "Belum punya akun ? ",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: "Daftar",
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
      "Masuk dengan google",
      style: TextStyle(
          fontSize: 14.5, color: Colors.black87, fontFamily: 'Poppins'),
    ),
  );
}
