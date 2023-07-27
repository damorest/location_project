import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({
    super.key,
    required this.title
  });

  final String title;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ЦЕ МОЯ ШИРИНА',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 15),
                Text(
                  'ЦЕ МОЯ ДОВГОТА',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
      ),
      floatingActionButton: Row (
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Start',
            child: const Icon(Icons.not_started_outlined),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Finish',
            child: const Icon(Icons.stop_circle),
          ), // This trailing comma m// This trailing comma m
        ],
      ),
    );
  }
}
