import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  Stream<Position> streamController = Geolocator.getPositionStream();


  @override
  void dispose() {
    streamController.listen((event) {}).cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //Position? _currentLocation;

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
                  Geolocator.openAppSettings();
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        //centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
            stream: streamController,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              }
              if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return
                  Column(
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
          ElevatedButton(
            onPressed: () async {
              print('START');
              streamController.listen(
                      (Position? position) {
                    lat = position?.latitude.toString();
                    print('LAT : $lat');
                    long = position?.longitude.toString();
                    print('LONG : $long');
                  });
            },
            child: const Text("get location"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              dispose();
              print('STOP');
            },
            child: const Text("stop location"),
          ), // This trailing comma m// This trailing comma m
        ],
      ),
    );
  }

  Future <Position> getLocation() async =>
      LocationService().determinePosition();

  Future<Future<StreamSubscription>?> getStream() async =>
      LocationService().streamPosition();
}
