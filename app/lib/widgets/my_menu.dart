import 'package:app/consts/app_const.dart';
import 'package:app/screens/geo_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/services/storage_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyMenu extends StatelessWidget {
  static final Logger _logger = Logger();

  const MyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: FutureBuilder<String>(
              future: StorageService.getValue(AppConst.nameLabel),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(snapshot.data ?? '');
                } else if (snapshot.hasError) {
                  return const Text("Nombre");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            accountEmail: FutureBuilder<String>(
              future: StorageService.getValue(AppConst.emailLabel),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(snapshot.data ?? '');
                } else if (snapshot.hasError) {
                  return const Text("usuario@correo.cl");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: FutureBuilder(
                  future: StorageService.getValue(AppConst.photoUrlLabel),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String url = snapshot.data ?? '';
                      if (url.isNotEmpty) {
                        //return Image.network(url);
                        return CachedNetworkImage(
                          imageUrl: url,
                          placeholder: (context, url) {
                            return const CircularProgressIndicator();
                          },
                          errorWidget: (context, url, error) {
                            _logger.e(error);
                            return const Icon(
                              Icons.person_3,
                              color: Colors.red,
                              size: 47,
                            );
                          },
                        );
                      } else {
                        return const Icon(Icons.person_4);
                      }
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.person);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Ubicación'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const GeoScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
