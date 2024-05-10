import 'dart:convert';
import 'package:chola_driver_flutter/Widgets/snackbar.dart';
import 'package:http/http.dart' as http; // Or 'package:dio/dio.dart' as dio;

class ApiService {
  // final String baseUrl = "https://chola-web-app.azurewebsites.net/api";

  Future<void> getDriverLocation(
      double latitude, double longitude, String city) async {
    final response = await http.post(
      Uri.parse("https://chola-web-app.azurewebsites.net/api/user/goLive"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzYsImZpcnN0TmFtZSI6IkRyaXZlciIsImxhc3ROYW1lIjoiZGtkayIsImNvdW50cnlDb2RlIjoiKzkxIiwicGhvbmVObyI6Ijg1NjY3NjY3MjMiLCJwaG9uZU5vVmVyaWZpZWQiOnRydWUsImVtYWlsIjpudWxsLCJlbWFpbFZlcmlmaWVkIjpmYWxzZSwidmVyaWZpZWQiOmZhbHNlLCJ1c2VyVHlwZSI6MSwiZG9iIjoiMTk0Ni0xMi0wMlQxODozMDowMC4wMDBaIiwiZ2VuZGVyIjowLCJwcm9maWxlSW1hZ2UiOm51bGwsImJsb29kR3JvdXAiOjAsInJlZ2lzdGVyZWRPbiI6IjIwMjQtMDQtMDVUMTM6NTc6MjQuODI4WiIsInVwZGF0ZWRPbiI6IjIwMjQtMDQtMDVUMjA6NDc6MzUuMTUwWiIsImlzQmFubmVkIjpmYWxzZSwiYmFubmVkQnlJZCI6bnVsbCwiYmFubmVkUmVhc29uIjpudWxsLCJpc1RlbXBEZWxldGVkIjpmYWxzZSwiY2l0eSI6IkphbGFuZGhhciIsInN0YXRlIjoiUHVuamFiIiwiY291bnRyeSI6IkluZGlhIiwib3RwIjpudWxsLCJkcml2ZXIiOnsiaWQiOjMxfSwicmlkZXIiOm51bGwsImlhdCI6MTcxNDY0OTkyNn0.HRguajomfe-Ccx6u8TFOW--WcsrwuvlgfKvHwvrk1fE',
      },
      body: jsonEncode(
          {"latitude": latitude, "longitude": longitude, "city": city}),
    );
    print('$latitude, $longitude, $city');
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      CustomSnackbar.showSuccess("Success", "Driver is online");
    } else {
      // Handle error cases
      CustomSnackbar.showError("Error", "Connection not Established");
      throw Exception('Failed to fetch passenger location');
    }
  }

  Future<void> goOffline() async {}
}
