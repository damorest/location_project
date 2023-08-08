import 'package:first/blocs/geolocation_bloc.dart';
import 'package:first/repositories/main_repositories.dart';
import 'package:first/screen/main_page_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<GeolocationRepositories>(
        create: (_) => GeolocationRepositories(),)
    ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => GeolocationBloc(geolocationRepository: context.read<GeolocationRepositories>())
              ..add(LoadGeolocation()))
          ],
          child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
      ),
      home: const LocationPage(
            title: 'Flutter location'),
    ),
        )
    );
  }
}

