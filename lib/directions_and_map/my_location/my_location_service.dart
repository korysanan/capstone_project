import 'package:geolocator/geolocator.dart';
import '../../globals.dart' as globals;

class LocationService {
  static Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    } 

    // Permissions are granted, continue accessing the device's location.
    Position position = await Geolocator.getCurrentPosition();
    globals.my_latitude = position.latitude;
    globals.my_longitude = position.longitude;
  }
}
