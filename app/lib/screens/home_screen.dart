import 'package:app/services/storage_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Página de inicio")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<String>(
                future: StorageService.getValue('name'),
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
                future: StorageService.getValue('email'),
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
                    future: StorageService.getValue('photoUrl'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        String url = snapshot.data ?? '';
                        if (url.isNotEmpty) {
                          return Image.network(url);
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
          ],
        ),
      ),
    );
  }
}
