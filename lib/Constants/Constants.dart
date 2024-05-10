import 'dart:convert';
import 'dart:io';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/main.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Constants {
  static bool switchValue = false;
    /// Compresses the given [file] using the FlutterImageCompress library.
  ///
  /// The function takes a [File] object as input and returns a [Future] that
  /// resolves to a [File] object representing the compressed file. The original
  /// file is returned if compression is not supported or fails.
  ///
  /// The function uses the [FlutterImageCompress.compressAndGetFile] method to
  /// compress the file. The [quality]
  static Future<File> compressFile(File file) async {
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        file.absolute.path,
        quality: 10, // Adjust the quality as needed (0-100)
      );
      if (result == null) {
        // Compression not supported, return original file
        return file;
      }
      print('Compressed image size: ${result.length()} bytes');
      return File(result.path);
    } catch (e) {
      print('Error compressing image: $e');
      // Compression failed, return original file
      return file;
    }
  }
  /// Asynchronously navigates to a URL obtained from the `ApiCollection.onUpdateApi()` method.
  ///
  /// This function sends a GET request to the server to update the API and obtains the URL from the response body.
  /// It then checks if the URL can be launched using the `canLaunch()` method. If the URL can be launched,
  /// it launches the URL using the `launch()` method. If the URL cannot be launched, an exception is thrown.
  ///
  /// Returns:
  /// - A `Future` that resolves to `void`.
  ///
  /// Throws:
  /// - An exception if the URL cannot be launched.
  static Future<void> navigateToUrl() async {
    String url = await ApiCollection.onUpdateApi();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Fetches the result from a JSON file.
  ///
  /// This function reads the content of a JSON file located in the application's documents directory.
  /// If the file exists, it decodes the content into a map and returns it.
  /// If the file does not exist or if there is an error reading the file, an empty map is returned.
  ///
  /// Returns:
  /// - A `Future` that resolves to a `Map<String, dynamic>`.
  static Future<Map<String, dynamic>> fetchResult() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/result.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        return jsonDecode(content);
      }
    } catch (e) {
      print('Error reading file: $e');
    }
    return {};
  }

  static const List<String> ads = [
    'https://www.wordstream.com/wp-content/uploads/2021/07/persuasive-ads-coca-cola-1.jpg',
    'https://www.wordstream.com/wp-content/uploads/2021/07/persuasive-ads-street-easy.jpg',
  ];
  static Map<String, dynamic> user_data = {};
  static Map<String, dynamic> user_data1 = {};
  static Map<String, dynamic> documents_data = {};
  static const List<String> countryCodes = ['+91'];
  static String firstName = '';
  static String phoneNo = '+91 1234567890';
  static String jwt = '';
  static const List<String> vehicleCompany = [
    'Maruti-Suzuki',
    'Hyundai',
    'Tata-Motors',
    'Mahindra',
    'Kia',
    'Toyota',
    'Honda',
    'Renault',
    'Skoda',
    'MG',
  ];
  static const List<String> registeredType = ['PhoneNumber', 'Email'];
  static const Color themeColor = Color(0xFFFFF8D7);
  static const List<String> flexiRide = [
    'Flexi Bookings are just like our popular Day-Rider Bookings.',
    'Book your ride in advance and Schedule your pickup at  your convince  with in 24 Hours.',
    'You can Book for Yourself or for Others.',
    'Save your precious time and be hazel free.',
  ];
  static const List<String> futureRide = [
    'Choose your exact pickup time up to 90 days in advance.',
    'Extra wait time included to meet your ride',
    'Cancel at no charge up to 60 minutes in advance.',
  ];
  static const List<String> intercityRide = [
    'Choose your exact pickup time up to 90 days in advance.',
    'Extra wait time included to meet your ride',
    'Cancel at no charge up to 60 minutes in advance.',
  ];
  static LatLng latLang = LatLng(0, 0);
  static List<Map<String, String>> destinationList = [
    // {
    //   'address':
    //       '8946 Essex St. Sunnyside, In46321 Very Long Address Here Very Long Address Here Very Long Address Here',
    //   'locality': 'Giga Mall Plaza',
    // },
    // {
    //   'address': '123 Main St, Springfield, IL 62701',
    //   'locality': 'Downtown',
    // },
    // {
    //   'address': '456 Elm St, Springfield, IL 62702',
    //   'locality': 'West Side',
    // },
    // {
    //   'address': '789 Oak St, Springfield, IL 62703',
    //   'locality': 'East Side',
    // },
    // {
    //   'address': '101 Pine St, Springfield, IL 62704',
    //   'locality': 'South Side',
    // },
    // {
    //   'address': '202 Maple St, Springfield, IL 62705',
    //   'locality': 'North Side',
    // },
    // {
    //   'address': '303 Cedar St, Springfield, IL 62706',
    //   'locality': 'Old Town',
    // },
    // {
    //   'address': '404 Walnut St, Springfield, IL 62707',
    //   'locality': 'Historic District',
    // },
    // {
    //   'address': '505 Spruce St, Springfield, IL 62708',
    //   'locality': 'Suburb',
    // },
    // {
    //   'address': '606 Birch St, Springfield, IL 62709',
    //   'locality': 'Rural Area',
    // },
  ];
  static const List<String> bloodGroup = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  static const List<String> gender = [
    'Male',
    'Female',
    'Other',
    'Prefer Not\n to Say'
  ];
  //List of the All the Banks in India :
  static const List<String> privateSectorBanks = [
    'Axis Bank Ltd.',
    'Bandhan Bank Ltd.',
    'CSB Bank Limited',
    'City Union Bank Ltd.',
    'DCB Bank Ltd.',
    'Dhanlaxmi Bank Ltd.',
    'Federal Bank Ltd.',
    'HDFC Bank Ltd',
    'ICICI Bank Ltd.',
    'IndusInd Bank Ltd',
    'IDFC FIRST Bank Limited',
    'Jammu & Kashmir Bank Ltd.',
    'Karnataka Bank Ltd.',
    'Karur Vysya Bank Ltd.',
    'Kotak Mahindra Bank Ltd',
    'Nainital bank Ltd.',
    'RBL Bank Ltd.',
    'South Indian Bank Ltd.',
    'Tamilnad Mercantile Bank Ltd.',
    'YES Bank Ltd.',
    'IDBI Bank Limited',
  ];

  static const List<String> privateSectorBankWebsite = [
    'https://www.axisbank.com',
    'https://www.bandhanbank.com',
    'https://www.csb.co.in',
    'https://www.cityunionbank.com',
    'https://www.dcbbank.com',
    'https://www.dhanbank.com',
    'https://www.federalbank.co.in',
    'https://www.hdfcbank.com',
    'https://www.icicibank.com',
    'https://www.indusind.com',
    'https://www.idfcbank.com',
    'https://www.jkbank.com',
    'https://www.karnatakabank.com',
    'https://www.kvb.co.in',
    'https://www.kotak.com',
    'https://www.nainitalbank.co.in',
    'https://www.rblbank.com',
    'https://www.southindianbank.com',
    'https://www.tmb.in',
    'https://www.yesbank.in',
    'https://www.idbi.in',
  ];

  static const List<String> localAreaBanks = [
    'Coastal Local Area Bank Ltd',
    'Krishna Bhima Samruddhi LAB Ltd',
  ];

  static const List<String> localAreaBankWebsite = [
    'http://www.coastalareabank.com/',
    'http://www.kbsbankindia.com/',
  ];

  static const List<String> smallFinanceBanks = [
    'Au Small Finance Bank Ltd.',
    'Capital Small Finance Bank Ltd',
    'Fincare Small Finance Bank Ltd.',
    'Equitas Small Finance Bank Ltd',
    'ESAF Small Finance Bank Ltd.',
    'Suryoday Small Finance Bank Ltd.',
    'Ujjivan Small Finance Bank Ltd.',
    'Utkarsh Small Finance Bank Ltd.',
    'North East Small finance Bank Ltd',
    'Jana Small Finance Bank Ltd',
    'Shivalik Small Finance Bank Ltd',
    'Unity Small Finance Bank Ltd',
  ];

  static const List<String> smallFinanceBankWebsite = [
    'https://www.aubank.in',
    'https://www.capitalbank.co.in',
    'https://fincarebank.com',
    'https://www.equitasbank.com',
    'https://www.esafbank.com',
    'https://www.suryodaybank.com',
    'https://www.ujjivansfb.in',
    'https://www.utkarsh.bank',
    'https://www.nesfb.com',
    'https://www.janabank.com',
    'https://www.shivalikbank.com',
    'https://theunitybank.com',
  ];

  static const List<String> paymentsBanks = [
    'Airtel Payments Bank Ltd',
    'India Post Payments Bank Ltd',
    'FINO Payments Bank Ltd',
    'Paytm Payments Bank Ltd',
    'Jio Payments Bank Ltd',
    'NSDL Payments Bank Limited',
  ];
  static const List<String> paymentsBankWebsite = [
    'https://www.airtel.in/bank',
    'https://www.ippbonline.com/web/ippb',
    'https://www.finobank.com',
    'https://www.paytmbank.com',
    'https://www.jiopaymentsbank.com',
    'https://www.nsdlbank.com',
  ];

  static const List<String> publicSectorBanks = [
    'Bank of Baroda',
    'Bank of India',
    'Bank of Maharashtra',
    'Canara Bank',
    'Central Bank of India',
    'Indian Bank',
    'Indian Overseas Bank',
    'Punjab & Sind Bank',
    'Punjab National Bank',
    'State Bank of India',
    'UCO Bank',
    'Union Bank of India',
  ];
  static const List<String> publicSectorBankWebsite = [
    'https://www.bankofbaroda.co.in',
    'https://www.bankofindia.co.in',
    'https://www.bankofmaharashtra.in',
    'https://www.canarabank.in',
    'https://www.centralbankofindia.co.in',
    'https://www.indianbank.in',
    'https://www.iob.in',
    'https://punjabandsindbank.co.in',
    'https://www.pnbindia.in',
    'https://www.sbi.co.in',
    'https://www.ucobank.com',
    'https://www.unionbankofindia.co.in',
  ];

  static const List<String> financialInstitutions = [
    'National Bank for Agriculture and Rural Development',
    'Export-Import Bank of India',
    'National Housing Bank',
    'Small Industries Development Bank of India',
  ];
  static const List<String> financialInstitutionWebsite = [
    'https://www.nabard.org',
    'https://www.eximbankindia.in',
    'https://www.nhb.org.in',
    'https://www.sidbi.in',
  ];

  static const List<String> regionalRuralBanks = [
    'Assam Gramin Vikash Bank',
    'Andhra Pradesh Grameena Vikas Bank',
    'Andhra Pragathi Grameena Bank',
    'Arunachal Pradesh Rural Bank',
    'Aryavart Bank',
    'Bangiya Gramin Vikash Bank',
    'Baroda Gujarat Gramin Bank',
    'Baroda Rajasthan Kshetriya Gramin Bank',
    'Baroda UP Bank',
    'Chaitanya Godavari GB',
    'Chhattisgarh Rajya Gramin Bank',
    'Dakshin Bihar Gramin Bank',
    'Ellaquai Dehati Bank',
    'Himachal Pradesh Gramin Bank',
    'J&K Grameen Bank',
    'Jharkhand Rajya Gramin Bank',
    'Karnataka Gramin Bank',
    'Karnataka Vikas Gramin Bank',
    'Kerala Gramin Bank',
    'Madhya Pradesh Gramin Bank',
    'Madhyanchal Gramin Bank',
    'Maharashtra Gramin Bank',
    'Manipur Rural Bank',
    'Meghalaya Rural Bank',
    'Mizoram Rural Bank',
    'Nagaland Rural Bank',
    'Odisha Gramya Bank',
    'Paschim Banga Gramin Bank',
    'Prathama U.P. Gramin Bank',
    'Puduvai Bharathiar Grama Bank',
    'Punjab Gramin Bank',
    'Rajasthan Marudhara Gramin Bank',
    'Saptagiri Grameena Bank',
    'Sarva Haryana Gramin Bank',
    'Saurashtra Gramin Bank',
    'Tamil Nadu Grama Bank',
    'Telangana Grameena Bank',
    'Tripura Gramin Bank',
    'Uttar Bihar Gramin Bank',
    'Utkal Grameen Bank',
    'Uttarbanga Kshetriya Gramin Bank',
    'Vidharbha Konkan Gramin Bank',
    'Uttarakhand Gramin Bank',
  ];
  static const List<String> regionalRuralBankWebsite = [
    'https://www.agvbank.co.in',
    'https://www.apgvbank.in',
    'https://www.apgb.in',
    'https://www.apruralbank.com',
    'http://www.aryavart-rrb.com',
    'https://www.bgvb.in',
    'https://www.bggb.in',
    'https://www.brkgb.com',
    'https://www.barodagraminbank.com',
    'https://www.cggb.in',
    'http://www.cgbank.in/',
    'https://www.dbgb.in',
    'https://www.edb.org.in',
    'https://www.hpgb.in',
    'https://www.jkgb.in',
    'https://www.jrgb.in',
    'http://www.karnatakagraminbank.com/',
    'https://www.kvgbank.com',
    'https://www.keralagbank.com',
    'https://www.mpgb.in',
    'https://www.mgbank.co.in',
    'https://www.mahagramin.in',
    'http://www.manipurruralbank.com/',
    'https://www.meghalayaruralbank.co.in',
    'https://www.mizoramruralbank.in/',
    'https://www.nagalandruralbank.com',
    'https://www.odishabank.in',
    'https://www.pbgbank.com',
    'http://www.prathamaupbank.com/',
    'http://www.puduvaibharathiargramabank.in/',
    'http://www.pgb.org.in/',
    'http://www.rmgb.in/',
    'http://www.saptagirigrameenabank.in/',
    'https://www.shgb.co.in',
    'https://www.sgbrrb.org',
    'http://www.tamilnadugramabank.com/',
    'https://www.tgbhyd.in',
    'https://www.tripuragraminbank.org',
    'https://www.ubgb.in',
    'http://www.utkalgrameenbank.co.in/',
    'https://www.ukgb.org',
    'https://www.vkgb.co.in',
    'https://www.uttarakhandgraminbank.com',
  ];

  static const List<String> foreignBanks = [
    'AB Bank Ltd.',
    'American Express Banking Corporation',
    'Australia and New Zealand Banking Group Ltd.',
    'Barclays Bank Plc.',
    'Bank of America',
    'Bank of Bahrain & Kuwait B.S.C.',
    'Bank of Ceylon',
    'Bank of China',
    'Bank of Nova Scotia',
    'BNP Paribas',
    'Citibank N.A.',
    'Cooperatieve Rabobank U.A./ Coöperatieve Centrale Raiffeisen-Boerenleenbank B.A.',
    'Credit Agricole Corporate & Investment Bank',
    'Credit Suisse AG',
    'CTBC Bank Co., Ltd.',
    'DBS Bank India Limited',
    'Deutsche Bank A.G.',
    'Doha Bank Q.P.S.C',
    'Emirates NBD Bank PJSC',
    'First Abu Dhabi Bank PJSC',
    'FirstRand Bank Limited',
    'Hong Kong and Shanghai Banking Corporation Limited',
    'Industrial & Commercial Bank of China Ltd.',
    'Industrial Bank of Korea',
    'J.P. Morgan Chase Bank N.A.',
    'JSC VTB Bank',
    'KEB Hana Bank',
    'Kookmin Bank',
    'Krung Thai Bank Public Co. Ltd.',
    'Mashreq bank PSC',
    'Mizuho Bank Ltd.',
    'MUFG Bank, Ltd.',
    'NatWest Markets Plc',
    'PT Bank Maybank Indonesia TBK',
    'Qatar National Bank (Q.P.S.C.)',
    'Sberbank',
    'SBM Bank (India) Limited',
    'Shinhan Bank',
    'Societe Generale India',
    'Sonali Bank PLC %',
    'Standard Chartered Bank',
    'Sumitomo Mitsui Banking Corporation',
    'United Overseas Bank Limited',
    'Woori Bank',
  ];

  static const List<String> foreignBankWebsite = [
    'https://abbl.com/mumbai-branch',
    'https://www.americanexpress.com/in',
    'https://www.anz.com.au/personal/',
    'https://www.barclays.in',
    'http://bofa-india.com/',
    'https://www.bbkonline.com',
    'http://www.bankofceylon.in/',
    'https://www.bankofchina.com',
    'http://www.scotiabank.com/',
    'http://www.bnpparibas.co.in/en/',
    'https://www.citibank.co.in',
    'https://www.rabobank.com',
    'https://www.ca-cib.com',
    'https://www.credit-suisse.com',
    'http://www.chinatrustindia.com/',
    'https://www.dbs.com',
    'http://www.deutschebank.co.in/',
    'https://dohabank.co.in',
    'https://www.emiratesnbd.co.in',
    'https://www.bankfab.com',
    'https://www.firstrand.co.in',
    'https://www.hsbc.co.in',
    'https://www.icbcindia.com',
    'https://in.globalibk.com/iview/03/CMIBMAN0000',
    'https://www.jpmorgan.com',
    'https://www.vtbindia.com',
    'https://global.1qbank.com/lounge/chennai/et/main.html',
    'https://www.kbfg.com',
    'https://krungthai.com/th/content/mumbai-branch',
    'https://www.mashreqbank.com',
    'https://www.mizuhobank.com',
    'https://www.bk.mufg.jp',
    'https://www.natwestmarkets.in',
    'https://www.maybank.co.in',
    'https://www.qnb.com',
    'https://www.sberbank.co.in',
    'https://www.sbmbank.co.in/',
    'https://in.shinhanglobal.com/',
    'https://www.societegenerale.asia',
    'https://www.sonalibank.in',
    'https://www.sc.com',
    'https://www.smbc.co.jp',
    'https://www.uobgroup.com/in',
    'https://go.wooribank.com/in/ib/main/IbMain.do',
  ];

  static const List<String> allBanks = [
    ...privateSectorBanks,
    ...localAreaBanks,
    ...regionalRuralBanks,
    ...foreignBanks,
    ...paymentsBanks,
    ...financialInstitutions,
    ...publicSectorBanks,
    ...smallFinanceBanks,
  ];
  static const List<String> allBanksWebsite = [
    ...privateSectorBankWebsite,
    ...localAreaBankWebsite,
    ...regionalRuralBankWebsite,
    ...foreignBankWebsite,
    ...paymentsBankWebsite,
    ...financialInstitutionWebsite,
    ...publicSectorBankWebsite,
    ...smallFinanceBankWebsite,
  ];

  static List<Map<String, String>> allBanksWithWebsite = List.generate(
    allBanks.length,
    (index) => {
      'Name': allBanks[index],
      'Site': allBanksWebsite[index],
    },
  );

  /// Shows an error dialog with the given [errorText] in the given [context].
  ///
  /// The [errorText] parameter represents the error message to be displayed.
  /// The [context] parameter represents the build context of the widget.
  ///
  /// This function retrieves the size of the screen using `MediaQuery.of(context).size`.
  /// It then shows a dialog using `showDialog` with the given [context].
  /// The dialog contains an `AlertDialog` widget with the following properties:
  /// - `actions`: A list containing a single `Center` widget with an `AgreeButton` widget.
  ///   - The `AgreeButton` widget has an `onPressed` callback that pops the dialog using `Navigator.of(context).pop()`.
  ///   - The `AgreeButton` widget has a `buttonText` property set to 'Okay'.
  ///   - The `AgreeButton` widget has a `padding` property set to 0.5.
  /// - `content`: A `Text` widget displaying the [errorText] with the following properties:
  ///   - `textAlign`: `TextAlign.center`.
  ///   - `style`: A `TextStyle` with the following properties:
  ///     - `color`: The text color is determined by `Theme.of(context).colorScheme.onBackground`.
  ///     - `fontSize`: The font size is calculated based on the shortest side of the screen size.
  ///     - `fontWeight`: `FontWeight.w500`.
  static void showError(BuildContext context, String errorText) {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Center(
              child: AgreeButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                buttonText: 'Okay',
                padding: .5,
              ),
            )
          ],
          content: Text(
            errorText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: size.shortestSide * 0.06,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
