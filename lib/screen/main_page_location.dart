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
  final StreamController streamController = new StreamController();

  // @override
  // void initState() {
  //   super.initState();
  //   getLocation();
  // }


  @override
  Widget build(BuildContext context) {
    Position? _currentLocation;
    // late bool servicePermission = false;
    // late LocationPermission permission;

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
        // child: StreamBuilder(
        //     stream: streamController.stream,
        //     initialData: 5,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const CircularProgressIndicator.adaptive();
        //       }
        //       if (snapshot.hasError) {
        //         return const Text('Error');
        //       } else {
        //         return
                  child: Column(
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
                ),
        //       }
        //     }
        // ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () async {
              _currentLocation = await getLocation();
              print('${_currentLocation}');
              setState(() {
                lat = _currentLocation?.latitude.toString();
                long = _currentLocation?.longitude.toString();
              });
            },
            child: const Text("get location"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              print('STOP');
            },
            child: const Text("stop location"),
          ), // This trailing comma m// This trailing comma m
        ],
      ),
    );
  }

  Future <Position> getLocation() async => LocationService().determinePosition();
  
  //
  // void getStream() async {
  //   final service = LocationService();
  //   final locationData = await service.getStreamLocation();
  //   final stream = streamController.sink.add(locationData);
  //   }

  }
