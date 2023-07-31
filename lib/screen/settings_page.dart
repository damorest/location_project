import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Setings'),
      ),
      //centerTitle: true,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('PUSH ME'),
              const SizedBox(height: 15),
              IconButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  icon: const Icon(Icons.settings)),
            ],
          )),
    );
  }
}
