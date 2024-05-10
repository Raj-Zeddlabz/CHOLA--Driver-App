import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddAadharCard.dart';
import 'package:chola_driver_flutter/Pages/AddBankAccount.dart';
import 'package:chola_driver_flutter/Pages/AddDocumnetsScreen.dart';
import 'package:chola_driver_flutter/Pages/AddDrivingLicense.dart';
import 'package:chola_driver_flutter/Pages/AddInsurance.dart';
import 'package:chola_driver_flutter/Pages/AddLivePhoto.dart';
import 'package:chola_driver_flutter/Pages/AddPan.dart';
import 'package:chola_driver_flutter/Pages/AddParmanentAddress.dart';
import 'package:chola_driver_flutter/Pages/AddRCCard.dart';
import 'package:chola_driver_flutter/Pages/AddVehicle.dart';
import 'package:chola_driver_flutter/Pages/AdditionalDocs.dart';
import 'package:chola_driver_flutter/Pages/Verifying.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/DocumentButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddDocument extends StatefulWidget {
  final bool? isVerifyAadhar;
  final bool? isVerifyPan;
  final bool? isVerifyDriverLicense;
  final bool? isVerifyRC;
  final bool? isVerifyInsurance;
  final bool? isVerifyPhoto;
  final bool? isVerifyVehicle;
  final bool? isVerifyPermanentAddress;
  final bool? isVerifyBankAccount;
  final bool? isVerifyConsult;
  const AddDocument({
    super.key,
    this.isVerifyAadhar,
    this.isVerifyPan,
    this.isVerifyDriverLicense,
    this.isVerifyRC,
    this.isVerifyInsurance,
    this.isVerifyPhoto,
    this.isVerifyVehicle,
    this.isVerifyPermanentAddress,
    this.isVerifyBankAccount,
    this.isVerifyConsult,
  });

  @override
  State<AddDocument> createState() => _AddDocumentState();

  static _AddDocumentState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AddDocumentState>();
}

class _AddDocumentState extends State<AddDocument> {
  bool isLoading = true;
  bool isVerifyAadhar = false;
  bool isVerifyPan = false;
  bool isVerifyDriverLicense = false;
  bool isVerifyRC = false;
  bool isVerifyInsurance = false;
  bool isVerifyPhoto = false;
  bool isVerifyVehicle = false;
  bool isVerifyPermanentAddress = false;
  // bool isVerifyAcknowledgement = false;
  bool isVerifyBankAccount = false;
  bool isVerifyCheck = false;
  bool isVerifyConsult = false;

  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    isVerifyAadhar = widget.isVerifyAadhar ?? false;
    isVerifyPan = widget.isVerifyPan ?? false;
    isVerifyDriverLicense = widget.isVerifyDriverLicense ?? false;
    isVerifyRC = widget.isVerifyRC ?? false;
    isVerifyInsurance = widget.isVerifyInsurance ?? false;
    isVerifyPhoto = widget.isVerifyPhoto ?? false;
    isVerifyVehicle = widget.isVerifyVehicle ?? false;
    isVerifyPermanentAddress = widget.isVerifyPermanentAddress ?? false;
    isVerifyBankAccount = widget.isVerifyBankAccount ?? false;
    isVerifyConsult = widget.isVerifyConsult ?? false;
    setLoadingFalseAfterDelay();
  }
  /// Sets the `isLoading` flag to `false` after a delay of 0 seconds.
  ///
  /// This function uses the `Future.delayed` method to schedule the execution of
  /// the provided callback function after the specified delay. The callback
  /// function updates the state of the widget by calling `setState` and setting
  /// the `isLoading` flag to `false`.
  ///
  /// This function does not take any parameters.
  ///
  /// There is no return value for this function.
  void setLoadingFalseAfterDelay() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  /// Sets the `isVerifyAadhar` flag to the provided `value`.
  ///
  /// The `value` parameter is a boolean that determines the new value of the `isVerifyAadhar` flag.
  ///
  /// This function does not return anything.
  void setAadharVerify(bool value) {
    setState(() {
      isVerifyAadhar = value;
    });
  }
    /// Sets the `isVerifyConsult` flag to the provided `value`.
    ///
    /// The `value` parameter is a boolean that determines the new value of the `isVerifyConsult` flag.
    ///
    /// This function does not return anything.
  void setConsultVerify(bool value) {
    setState(() {
      isVerifyConsult = value;
    });
  }
  /// Sets the `isVerifyPan` flag to the provided `value`.
  ///
  /// The `value` parameter is a boolean that determines the new value of the `isVerifyPan` flag.
  ///
  /// This function does not return anything.
  void setPanVerify(bool value) {
    setState(() {
      isVerifyPan = value;
    });
  }
// ALl Below Functions are for Verification of Documents
  void setDriverLicenseVerify(bool value) {
    setState(() {
      isVerifyDriverLicense = value;
    });
  }

  void setRCVerify(bool value) {
    setState(() {
      isVerifyRC = value;
    });
  }

  void setInsuranceVerify(bool value) {
    setState(() {
      isVerifyInsurance = value;
    });
  }

  void setPhotoVerify(bool value) {
    setState(() {
      isVerifyPhoto = value;
    });
  }

  void setVehicleDetailVerify(bool value) {
    setState(() {
      isVerifyVehicle = value;
    });
  }

  void setPermanentAddressVerify(bool value) {
    setState(() {
      isVerifyPermanentAddress = value;
    });
  }

  void setBankAccountVerify(bool value) {
    setState(() {
      isVerifyBankAccount = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          preferredHeight: size.height * 0.08,
          title: "Legal Records",
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: (isLoading)
            ? Skeletonizer(
                enabled: isLoading,
                child: ListView.builder(
                    itemCount: 10,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Item number $index as title',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.ac_unit,
                            size: 32,
                          ),
                        ),
                      );
                    }),
              )
            : SizedBox(
                height: size.height - statusBarHeight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.02,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DocumentButton(
                          isEnable: true,
                          label: 'Residence Address',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ParmanentAddress(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setPermanentAddressVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyPermanentAddress,
                        ),
                        DocumentButton(
                          isEnable: isVerifyPermanentAddress,
                          label: 'LivePhoto',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LivePhoto(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setPhotoVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyPhoto,
                        ),
                        DocumentButton(
                          isEnable: isVerifyPhoto,
                          label: 'Aadhar Card',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AadharCard(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setAadharVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyAadhar,
                        ),
                        DocumentButton(
                          isEnable: isVerifyAadhar,
                          label: 'Pan Card',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PanCard(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setPanVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyPan,
                        ),
                        DocumentButton(
                          isEnable: isVerifyPan,
                          label: 'Driver License',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrivingLicense(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setDriverLicenseVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyDriverLicense,
                        ),
                        DocumentButton(
                          isEnable: isVerifyDriverLicense,
                          label: 'Bank Account',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BankAccount(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setBankAccountVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyBankAccount,
                        ),
                        DocumentButton(
                          isEnable: isVerifyBankAccount,
                          label: 'Vehicle Details',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VehicleDetails(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setVehicleDetailVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyVehicle,
                        ),
                        DocumentButton(
                          isEnable: isVerifyVehicle,
                          label: 'Registration Card',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RCCard(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setRCVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyRC,
                        ),
                        DocumentButton(
                          isEnable: isVerifyRC,
                          label: 'Car Insurance',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Insurance(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setInsuranceVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyInsurance,
                        ),
                        DocumentButton(
                          isEnable: isVerifyInsurance,
                          label: 'Consult',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdditionalDocumnets(),
                              ),
                            ).then((value) {
                              if (value != null && value is bool) {
                                setConsultVerify(value);
                              }
                            });
                          },
                          isVerify: isVerifyConsult,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: SizedBox(
          height: ((isVerifyCheck) &&
                  (isVerifyPermanentAddress) &&
                  (isVerifyAadhar) &&
                  (isVerifyPan) &&
                  (isVerifyDriverLicense) &&
                  (isVerifyInsurance) &&
                  (isVerifyPhoto) &&
                  (isVerifyRC) &&
                  (isVerifyVehicle))
              ? size.height * 0.18
              : size.height * 0.12,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.001,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 20.0 / 385 * size.width,
                        height: 20.0 / 385 * size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Checkbox(
                          value: isVerifyCheck,
                          activeColor: Theme.of(context).colorScheme.background,
                          checkColor:
                              Theme.of(context).colorScheme.onBackground,
                          onChanged: (value) {
                            setState(() {
                              isVerifyCheck = value!;
                            });
                          },
                          // materialTapTargetSize:
                          //     MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        double fontSize = constraints.maxWidth * 0.045;
                        return Text(
                          'I hereby acknowledge given information is true to my knowledge.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: fontSize,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                ((isVerifyCheck) &&
                        (isVerifyPermanentAddress) &&
                        (isVerifyAadhar) &&
                        (isVerifyPan) &&
                        (isVerifyDriverLicense) &&
                        (isVerifyInsurance) &&
                        (isVerifyPhoto) &&
                        (isVerifyRC) &&
                        (isVerifyVehicle))
                    ? AgreeButton(
                        buttonText: "Submit",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Verifying(),
                            ),
                          );
                        },
                        padding: 0.7,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
