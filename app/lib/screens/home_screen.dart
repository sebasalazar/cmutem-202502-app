import 'package:app/consts/app_const.dart';
import 'package:app/model/weather_data.dart';
import 'package:app/services/rest_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/widgets/my_menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Página de inicio")),
      drawer: MyMenu(),
      body: Center(
        child: FutureBuilder(
          future: RestService.getWeather('SCEL'),
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              WeatherData? data = snapshot.data;
              if (data == null) {
                return const Text('ERROR');
              } else {
                return Text("La temperatura actual es ${data.temperature} a las ${data.updatedAt.hour}:${data.updatedAt.minute}:${data.updatedAt.second}");
              }
            } else if (snapshot.hasError) {
              return const Text('ERROR');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
