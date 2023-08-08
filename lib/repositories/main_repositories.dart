
import 'package:first/repositories/geolocation_repositories.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationRepositories extends BaseGeolocationRepository{
  GeolocationRepositories();

  @override
  Future<Position> getCurrentLocation() async{
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}