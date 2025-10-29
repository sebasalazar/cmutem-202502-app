import 'package:app/widgets/my_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class GeoScreenState extends State<GeoScreen> {
  static final Logger _logger = Logger();

  Future<LatLng> _currentPosition() async {
    PermissionStatus locationWhenInUse = await Permission.locationWhenInUse
        .request();
    _logger.i("Permiso: ${locationWhenInUse.name}");

    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('El GPS está deshabilitado');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('El permiso de ubicación fue permantemente denegado');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return Future.error('No se permite el acceso al GPS');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mi ubicación")),
      drawer: MyMenu(),
      body: FutureBuilder(
        future: _currentPosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            LatLng? geo = snapshot.data;
            if (geo != null) {
              return FlutterMap(
                options: MapOptions(initialCenter: geo, initialZoom: 17),
                children: [
                  TileLayer(
                    userAgentPackageName: 'cl.utem.cm',
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: geo,
                        child: const Icon(Icons.location_pin),
                        height: 80,
                        width: 80,
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Text("No fue posible determinar su ubicación");
            }
          } else if (snapshot.hasError) {
            return const Text("No fue posible determinar su ubicación");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class GeoScreen extends StatefulWidget {
  const GeoScreen({super.key});

  @override
  State<StatefulWidget> createState() => GeoScreenState();
}
