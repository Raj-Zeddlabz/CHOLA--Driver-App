import 'dart:convert';

import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:http/http.dart' as http;

class ApiCollection {
  //Api for create the User  in database
    /// Creates a phone number in the database.
  ///
  /// Parameters:
  /// - `phoneNo`: The phone number to be created.
  /// - `dialCode`: The dial code of the country.
  ///
  /// Returns:
  /// - A `Future` that resolves to the response body of the HTTP request.
  ///
  /// Throws:
  /// - An `Exception` if the HTTP request fails.
  static createPhoneNumber(String phoneNo, String dialCode) async {
    // print('dhjbcjdkbcdkj');
    // print(dialCode.runtimeType);
    var response = await http.post(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/enter'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'phoneNo': phoneNo.toString(),
        'countryCode': dialCode.toString(),
        'user_Type': 1,
        'auth_Type': 0,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create PhoneNumber.');
    }
  }

  /// Sends the driver's location to the server to indicate that the driver is "going live".
  ///
  /// The [driverLat] parameter represents the latitude of the driver's location.
  /// The [driverLng] parameter represents the longitude of the driver's location.
  /// The [city] parameter represents the name of the city where the driver is located.
  ///
  /// Returns a `Future` that resolves to the response body of the HTTP request.
  ///
  /// Throws an `Exception` if the HTTP request fails.
  static goLive(double driverLat, double driverLng, String city) async {
    print('dhjbcjdkbcdkj');
    // print(dialCode.runtimeType);
    Map<String, dynamic> x = await Constants.fetchResult();
    var response = await http.post(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/goLive'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        "latitude": driverLat,
        "longitude": driverLng,
        "city": city,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send Driver Location.');
    }
  }

  //Api for Verify Phone Number  
  /// Verifies the phone number in the database.
    ///
    /// This function sends a PUT request to the server to update the phone number verification status.
    /// The request includes the phone number verification status in the request body.
    ///
    /// Returns:
    /// - A `Future` that resolves to the response body of the HTTP request.
    ///
    /// Throws:
    /// - An `Exception` if the HTTP request fails.
  static verifyPhoneNumber() async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    // print(dialCode.runtimeType);
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'phoneNoVerified': true,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify PhoneNumber.');
    }
  }

  //Api for update the Email..
    /// Creates an email in the database.
  ///
  /// This function sends a PUT request to the server to update the email in the user's profile.
  /// The request includes the email in the request body.
  ///
  /// Parameters:
  /// - `email`: The email to be created.
  ///
  /// Returns:
  /// - A `Future` that resolves to the response body of the HTTP request.
  ///
  /// Throws:
  /// - An `Exception` if the HTTP request fails.

  static createEmail(String email) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    // print(dialCode.runtimeType);
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify PhoneNumber.');
    }
  }

  /// Verifies the email in the database.
  ///
  /// This function sends a PUT request to the server to update the email verification status.
  /// The request includes the email verification status in the request body.
  ///
  /// Returns:
  /// - A `Future` that resolves to the response body of the HTTP request.
  ///
  /// Throws:
  /// - An `Exception` if the HTTP request fails.
  static verifyEmail() async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    // print(dialCode.runtimeType);
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'verified': true,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify Email.');
    }
  }

  /// Creates details in the database.
  ///
  /// Parameters:
  /// - `firstName`: The first name of the user.
  /// - `lastName`: The last name of the user.
  /// - `gender`: The gender of the user.
  /// - `dob`: The date of birth of the user.
  /// - `bloodGroup`: The blood group of the user.
  ///
  /// Returns:
  /// - A `Future` that resolves to the response body of the HTTP request.
  ///
  /// Throws:
  /// - An `Exception` if the HTTP request fails.
  static createDetails(String firstName, String lastName, int gender,
      String dob, int bloodGroup) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    // print(dialCode.runtimeType);
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'dob': dob,
        'bloodGroup': bloodGroup,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Details.');
    }
  }
    /// Updates the city name in the database.
  ///
  /// Parameters:
  /// - `cityName`: The name of the city to be updated.
  ///
  /// Returns:
  /// - A `Future` that resolves to the response body of the HTTP request.
  ///
  /// Throws:
  /// - An `Exception` if the HTTP request fails.
  static updateCity(String cityName) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    // print(dialCode.runtimeType);
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/auth/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'cityName': cityName,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update City.');
    }
  }
  /// Updates the residence address in the database.
  ///
  /// Parameters:
  /// - `houseNo`: The house number of the residence address.
  /// - `apartment`: The apartment or suite number of the residence address.
  /// - `address1`: The first line of the address.
  /// - `address2`: The second line of the address.
  /// - `city`: The city of the residence address.
  /// - `state`: The state or province of the residence address.
  /// - `country`: The country of the residence address.
  /// - `postalCode`: The postal code of the residence address.
  ///
  /// Returns:
  /// - A `Future` that resolves to the response body of the HTTP request.
  ///
  /// Throws:
  /// - An `Exception` if the HTTP request fails.
  static updateResidenceAddress(
      String houseNo,
      String apartment,
      String address1,
      String address2,
      String city,
      String state,
      String country,
      String postalCode) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'userId': Constants.user_data['user']['id'],
        'houseNumber': houseNo,
        'apartmentSuit': apartment,
        'address1': address1,
        'address2': address2,
        'city': city,
        'state': state,
        'country': country,
        'postalCode': postalCode,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Residence Address.');
    }
  }

  // Updates the Aadhar Card information for a user.
  // Parameters:
  //   aadharCardNo: The Aadhar Card number to update.
  //   aadharFront: The front image of the Aadhar Card.
  //   aadharBack: The back image of the Aadhar Card.
  // Returns:
  //   If the update is successful, returns the updated Aadhar Card information.
  //   Throws an exception if the update fails.
  static updateAadharCard(
      String aadharCardNo, String aadharFront, String aadharBack) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'userId': Constants.user_data['user']['id'],
        'aadharCardNo': aadharCardNo,
        'aadharFront': aadharFront,
        'aadharBack': aadharBack,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Aadhar Card.');
    }
  }
  // Updates the PAN card details for a user.
  //
  // This function sends a PUT request to the server to update the PAN card details
  // of the user. It requires the PAN card number, front image, and back image of the
  // PAN card as parameters. The function returns a [Future] that resolves to the
  // response from the server.
  //
  // Parameters:
  // - `panCardNo` (String): The PAN card number.
  // - `panFront` (String): The front image of the PAN card.
  // - `panBack` (String): The back image of the PAN card.
  //
  // Returns:
  // - `Future<dynamic>`: A [Future] that resolves to the response from the server.
  //
  // Throws:
  // - `Exception`: If the PUT request fails with a status code other than 200.
  static updatePanCard(
      String panCardNo, String panFront, String panBack) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'userId': Constants.user_data['user']['id'],
        'panCardNo': panCardNo,
        'panFront': panFront,
        'panBack': panBack,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update PAN Card.');
    }
  }
  /// Updates the driving license information for a user.
  ///
  /// Parameters:
  /// - `licenceNo` (String): The license number of the driving license.
  /// - `licenseExpiryDate` (String): The expiry date of the driving license.
  /// - `licenceFront` (String): The front image of the driving license.
  /// - `licenceBack` (String): The back image of the driving license.
  ///
  /// Returns:
  /// - `Future<dynamic>`: A [Future] that resolves to the response from the server.
  ///
  /// Throws:
  /// - `Exception`: If the PUT request fails with a status code other than 200.
  static updateDrivingLicense(
    String licenceNo,
    String licenseExpiryDate,
    String licenceFront,
    String licenceBack,
  ) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'userId': Constants.user_data['user']['id'],
        'licenceNo': licenceNo,
        'licenseExpiryDate': licenseExpiryDate,
        'licenceFront': licenceFront,
        'licenceBack': licenceBack,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Driving License.');
    }
  }
/// Updates the bank details of a user.
///
/// [accHolderName] - The name of the account holder.
/// [accountNumber] - The account number.
/// [ifsc] - The IFSC code of the bank.
/// [branchName] - The name of the bank branch.
/// [bankName] - The name of the bank.
///
/// Returns a [Future] containing the updated bank details.
/// Throws an [Exception] if the update fails.
  static updateBankDetails(
    String accHolderName,
    String accountNumber,
    String ifsc,
    String branchName,
    String bankName,
  ) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'userId': Constants.user_data['user']['id'],
        'userName': accHolderName,
        'accountNumber': accountNumber,
        'ifsc': ifsc,
        'branchName': branchName,
        'bankName': bankName,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Bank Details.');
    }
  }
  /// Updates the live photo of the user.
  ///
  /// This function sends a PUT request to the server to update the live photo
  /// of the user. The [livePhoto] parameter is the URL of the new live photo.
  ///
  /// Returns a `Future` that resolves to the response body of the HTTP request.
  ///
  /// Throws an `Exception` if the HTTP request fails.
  static updateLivePhoto(
    String livePhoto,
  ) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'userId': Constants.user_data['user']['id'],
        'livePhoto': livePhoto,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Live Photo.');
    }
  }
/// Updates the vehicle details in the server.
///
/// The function takes in the following parameters:
/// - `vehicleType`: The type of the vehicle.
/// - `vehicleCompany`: The company of the vehicle.
/// - `vehicleModel`: The model of the vehicle.
/// - `vehicleYear`: The year of the vehicle.
/// - `vehicleColor`: The color of the vehicle.
/// - `licensePlateNo`: The license plate number of the vehicle.
/// - `vehiclePicture`: The picture of the vehicle.
///
/// The function returns a `Future` that resolves to the updated vehicle details.
///
/// Throws an `Exception` if the HTTP request fails.
  static updateVehicleDetails(
    String vehicleType,
    String vehicleCompany,
    String vehicleModel,
    String vehicleYear,
    String vehicleColor,
    String licensePlateNo,
    String vehiclePicture,
  ) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        'userId': Constants.user_data['user']['id'],
        "vehicleType": vehicleType,
        "vehicleCompany": vehicleCompany,
        "vehicleModel": vehicleModel,
        "vehicleYear": vehicleYear,
        "vehicleColor": vehicleColor,
        "licensePlateNo": licensePlateNo,
        "vehiclePicture": vehiclePicture,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Vehicle Details');
    }
  }
  /// Updates the RC (Registration Card) details for a user.
  ///
  /// Parameters:
  /// - `registrationCard` (String): The registration card number.
  /// - `registrationExpiryDate` (String): The expiry date of the registration card.
  /// - `registrationFront` (String): The front image of the registration card.
  /// - `registrationBack` (String): The back image of the registration card.
  ///
  /// Returns:
  /// - `Future<dynamic>`: A [Future] that resolves to the response from the server.
  ///
  /// Throws:
  /// - `Exception`: If the PUT request fails with a status code other than 200.
  static updateRc(
    String registrationCard,
    String registrationExpiryDate,
    String registrationFront,
    String registrationBack,
  ) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        "userId": Constants.user_data['user']['id'],
        "registrationCard": registrationCard,
        "registrationExpiryDate": registrationExpiryDate,
        "registrationFront": registrationFront,
        "registrationBack": registrationBack,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update RC Details');
    }
  }
  /// Updates the car insurance details of a user.
  ///
  /// [carinsuranceNo] - The car insurance number.
  /// [expiryDateCarInsurance] - The expiry date of the car insurance.
  /// [carInsuranceFront] - The front image of the car insurance.
  /// [carInsuranceBack] - The back image of the car insurance.
  ///
  /// Returns a [Future] containing the updated car insurance details.
  /// Throws an [Exception] if the update fails.
  static updateCarInsurance(
    String carinsuranceNo,
    String expiryDateCarInsurance,
    String carInsuranceFront,
    String carInsuranceBack,
  ) async {
    Map<String, dynamic> x = await Constants.fetchResult();
    print('dhjbcjdkbcdkj');
    var response = await http.put(
      Uri.parse('https://chola-web-app.azurewebsites.net/api/user/document'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${x['jwt']}',
      },
      body: jsonEncode({
        "userId": Constants.user_data['user']['id'],
        "carinsuranceNo": carinsuranceNo,
        "expiryDateCarInsurance": expiryDateCarInsurance,
        "carInsuranceFront": carInsuranceFront,
        "carInsuranceBack": carInsuranceBack,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update car Insurance Details.');
    }
  }
  /// Asynchronously updates the API by sending a GET request to the server.
  ///
  /// This function sends a GET request to the server to update the API.
  /// It includes the JWT token in the request headers for authorization.
  ///
  /// Returns:
  /// - A `Future` that resolves to the URL from the response body if the request is successful.
  ///
  /// Throws:
  /// - An `Exception` if the request fails or if the response status code is not 200.
  static Future<String> onUpdateApi() async {
    try {
      Map<String, dynamic> x = await Constants.fetchResult();
      var response = await http.get(
        Uri.parse('https://chola-web-app.azurewebsites.net/api/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${x['jwt']}',
          // Add any additional headers if required
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['url'];
      } else {
        throw Exception('Failed to fetch URL');
      }
    } catch (e) {
      throw Exception('Failed to fetch URL: $e');
    }
  }
}
