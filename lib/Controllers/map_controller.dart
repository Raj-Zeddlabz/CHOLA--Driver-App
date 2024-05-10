import 'package:chola_driver_flutter/Services/online_driver_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  Position? currentPosition;
  RxBool isOnline = false.obs;

  Future<void> updateOnlineStatus(bool val) async {
    isOnline.value = val;

    if (isOnline.value && currentPosition != null) {
      final latitude = currentPosition!.latitude;
      final longitude = currentPosition!.longitude;
      final city = "moradabad";
      try {
        await ApiService().getDriverLocation(latitude, longitude, city);
        // Handle success response (e.g., show a message)
        print("Driver is online!");
      } catch (e) {
        // Handle error response
        print("Error going online: $e");
      }
    } else {}
  }
}
