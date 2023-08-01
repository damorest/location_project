import 'dart:async';
import 'package:first/screen/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../network/location_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<LocationPage> createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage> {
  String? lat;
  String? long;
  final StreamController streamController = new StreamController();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> _showInfoDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Доступ до геолокації'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Надайте доступ'),
                InkWell(
                    child: const Text(
                      'до геолокації',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {}),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            const SizedBox(width: 10),
            IconButton(
                onPressed: () {
                  _showInfoDialog();
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        //centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
            stream: streamController.stream,
            initialData: 5,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              }
              if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Latitude:${lat ?? 'Loading ...'}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      ' Longitude: ${long ?? 'Loading ...'}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ],
                );
              }
            }
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
             getStream();
            },
            tooltip: 'Start',
            child: const Icon(Icons.not_started_outlined),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
            },
            tooltip: 'Finish',
            child: const Icon(Icons.stop_circle),
          ), // This trailing comma m// This trailing comma m
        ],
      ),
    );
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      setState(() {
        lat = locationData.latitude!.toStringAsFixed(2);
        long = locationData.longitude!.toStringAsFixed(2);
      });
    }
  }

  void getStream() async {
    final service = LocationService();
    final locationData = await service.getStreamLocation();
    final stream = streamController.sink.add(locationData);
    }

  }
