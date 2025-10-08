import 'package:app/screens/error_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/services/google_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatelessWidget {
  static final Logger _logger = Logger();

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  GoogleService().logIn(context).then((ok) {
                    if (ok) {
                      _logger.i("Logueo exitoso");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    } else {
                      _logger.e("Logueo fallido");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ErrorScreen();
                          },
                        ),
                      );
                    }
                  });
                },
                child: Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
