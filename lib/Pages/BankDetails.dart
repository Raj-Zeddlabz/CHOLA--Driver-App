// import 'dart:async';

import 'package:chola_driver_flutter/Constants/ApiCollection.dart';
import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/VerifyBankDetails.dart';
import 'package:chola_driver_flutter/Widgets/Buttonfill.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:chola_driver_flutter/Widgets/Field.dart';
import 'package:flutter/material.dart';

class BankDetails extends StatefulWidget {
  final String bankName;
  final String bankSite;
  const BankDetails({
    super.key,
    required this.bankName,
    required this.bankSite,
  });

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController =
      TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = "";
  void initState() {
    print(widget.bankName);
    print(widget.bankSite);
    super.initState();
  }
  /// Returns an error message if the account number entered in the
  /// `confirmAccountNumberController` does not match the account number entered
  /// in the `accountNumberController`. Returns `null` otherwise.
  String? getErrorMessage() {
    if (confirmAccountNumberController.text != accountNumberController.text) {
      return "Account number doesn't match";
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          preferredHeight: size.height * 0.08,
          title: "Bank Account",
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: SizedBox(
            height: size.height - statusBarHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
                vertical: size.height * 0.02,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: size.height * 0.05,
                    // ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.bankName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.shortestSide * 0.06,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: size.height * 0.01,
                    // ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: FittedBox(
                    //     fit: BoxFit.scaleDown,
                    //     child: Text(
                    //       widget.bankSite,
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 1,
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: size.shortestSide * 0.03,
                    //         color: Color(0xff717171),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width,
                          height: size.height / 1.5,
                          decoration: BoxDecoration(
                            color: Color(0xFFBAC1FF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: 6,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: size.height * 0.01),
                              itemBuilder: (BuildContext context, int index) {
                                switch (index) {
                                  case 0:
                                    return Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.02,
                                                vertical: size.height * 0.01,
                                              ),
                                              child: Text(
                                                'Enter Account Details', //Centerized The Screen
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize:
                                                      size.shortestSide * 0.06,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.black,
                                        )
                                      ],
                                    );

                                  case 1:
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.03,
                                      ),
                                      child: Field(
                                        labelText: "Account Holder's Name",
                                        isLabel: true,
                                        hintText: "Enter Bank Holder Name",
                                        vertical: 0.03,
                                        horizontal: 0.04,
                                        borderColor: BorderSide.none,
                                        snackbarText: '* Required',
                                        keyboardType: TextInputType.name,
                                        fieldController: nameController,
                                      ),
                                    );

                                  case 2:
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.03,
                                      ),
                                      child: Field(
                                        labelText: "Account Number",
                                        isLabel: true,
                                        hintText: "Enter Your Account Number",
                                        vertical: 0.03,
                                        horizontal: 0.03,
                                        borderColor: BorderSide.none,
                                        keyboardType: TextInputType.number,
                                        snackbarText: '* Required',
                                        fieldController:
                                            accountNumberController,
                                      ),
                                    );

                                  case 3:
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.03,
                                      ),
                                      child: Field(
                                        labelText: "Re-Enter Account Number",
                                        isLabel: true,
                                        hintText: "Enter Your Account Number",
                                        vertical: 0.03,
                                        horizontal: 0.03,
                                        borderColor: BorderSide.none,
                                        keyboardType: TextInputType.number,
                                        snackbarText: errorMessage,
                                        onChanged: (value) {
                                          _formKey.currentState!.validate();
                                        },
                                        validator: (value) => getErrorMessage(),
                                        fieldController:
                                            confirmAccountNumberController,
                                      ),
                                    );

                                  case 4:
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.03,
                                      ),
                                      child: Field(
                                        labelText: "IFSC Code",
                                        isLabel: true,
                                        hintText:
                                            "Enter Your IFSC/Routing Number",
                                        vertical: 0.03,
                                        horizontal: 0.03,
                                        borderColor: BorderSide.none,
                                        snackbarText: '* Required',
                                        fieldController: ifscController,
                                      ),
                                    );

                                  case 5:
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.03,
                                      ),
                                      child: Field(
                                        labelText: "Branch",
                                        isLabel: true,
                                        hintText: "Enter Your Branch",
                                        vertical: 0.03,
                                        horizontal: 0.03,
                                        borderColor: BorderSide.none,
                                        snackbarText: '* Required',
                                        fieldController: branchController,
                                      ),
                                    );

                                  default:
                                    return SizedBox();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: size.height * 0.02,
                        ),
                        child: AgreeButton(
                          buttonText: "Confirm",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (accountNumberController.text !=
                                  confirmAccountNumberController.text) {
                                Constants.showError(context,
                                    'Account Number and Confirm Account Number must be Same');
                              } else {
                                // Map<String, dynamic> result =
                                //     await ApiCollection.updateBankDetails(
                                //   nameController.text,
                                //   accountNumberController.text,
                                //   ifscController.text,
                                //   branchController.text,
                                //   widget.bankName,
                                // );
                                // print(result);
                                // Handle saving the address here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifyBankDetails(
                                      bankName: widget.bankName,
                                      bankSite: widget.bankSite,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          padding: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
