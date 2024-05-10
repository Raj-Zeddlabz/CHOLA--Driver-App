class PassengerLocation {
  final double latitude;
  final double longitude;
  final String city;

  PassengerLocation({
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  factory PassengerLocation.fromJson(Map<String, dynamic> json) {
    return PassengerLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      city: json['city'],
    );
  }
}