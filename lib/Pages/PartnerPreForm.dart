import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Widgets/Cards.dart';
import 'package:chola_driver_flutter/Widgets/CustomAppbar.dart';
import 'package:flutter/material.dart';

class PartnerPreForm extends StatefulWidget {
  const PartnerPreForm({super.key});

  @override
  State<PartnerPreForm> createState() => _PartnerPreFormState();
}
/// Builds the widget tree for the PartnerPreForm.
///
/// The [context] parameter is the build context for the widget.
/// Returns a [Widget] representing the built widget tree.
class _PartnerPreFormState extends State<PartnerPreForm> {
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
          title: "Partner Pre-Form",
          preferredHeight: size.height * 0.08,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
          height: size.height - statusBarHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CardRow1(
                  colors: [
                    Color(0xff463FD2),
                    Color(0xffB906A7),
                    Color(0xff7202E3),
                    Color(0xff0C851F),
                    Color(0xff801A13),
                  ],
                  preferredSizeHeight: statusBarHeight + size.height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
