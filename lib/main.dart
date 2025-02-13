import 'package:flutter/material.dart';
import 'package:my_solonet_app/auth/login.dart';
import 'package:my_solonet_app/home/home_screen.dart';
import 'package:my_solonet_app/home/home_user_baru.dart';
import 'package:my_solonet_app/splashscreen/splashscreen.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomeScreen(),
      home: SignInScreen(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print('Login button pressed');
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
