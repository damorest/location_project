import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.
    getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
Future<StreamSubscription>? streamPosition() {
  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 1,
  );
  StreamSubscription<Position> positionStream =
  Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position? position) {
        print(position == null ? 'Unknown' : '${position.latitude
            .toString()}, ${position.longitude.toString()}');
      });
}

}