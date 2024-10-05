import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:my_solonet_app/auth/forget_pass.dart';
import 'package:my_solonet_app/auth/register.dart';
import 'package:my_solonet_app/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginUser(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // final url = Uri.parse("${baseUrl}login");
    // final headers = {
    //   "Access-Control-Allow-Origin": "*",
    //   'Content-Type': 'application/json',
    //   'Accept': '*/*',
    // };
    // final body = json.encode({
    //   "email": _emailController.text,
    //   "password": _passwordController.text,
    // });

    // try {
    //   final response = await http.post(
    //     url,
    //     headers: headers,
    //     body: body,
    //   );
    //   if (response.statusCode == 200) {
    //     final responseData = json.decode(response.body);
    //     showSuccessMessage(context, responseData['message']);
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const HomeScreen()),
    //     );
    //   } else {
    //     final responseData = json.decode(response.body)['message'];
    //     showFailedMessage(context, responseData);
    //   }
    // } catch (e) {
    //   showFailedMessage(context, 'An error occurred: $e');
    // } finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
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
                                'Email',
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
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Enter Email',
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
                                'Password',
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
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Enter Password',
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
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightBlue,
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
                              backgroundColor: Colors.lightBlue,
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
                                    "Login",
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
          text: "Already have an account? ",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: "Sign Up",
              style: TextStyle(
                color: Colors.lightBlue,
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
      "Sign up with Google",
      style: TextStyle(fontSize: 14.5, fontFamily: 'Poppins'),
    ),
  );
}
