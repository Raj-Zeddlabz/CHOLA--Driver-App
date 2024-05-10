import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  @override
  _TermsAndConditionsWidgetState createState() =>
      _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  @override
    // Widget build method that returns a RichText widget displaying the terms and conditions of using the CHOLA Chariots service.
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          children: [
            TextSpan(
              text:
                  "By accessing and working with us, you confirm that you agree with and are bound by the terms of service in the Terms & Conditions outlined below. These terms apply to the entire App and any email or other type of communication between you and Under no circumstances shall the team be liable for any direct, indirect, special, incidental or consequential damages, including, but not limited to loss of data or profit, arising out of use, or the inability to use, the materials on this App, even if the team or an authorized representative has been advised of the possibility of such damages. \n\n",
            ),
            TextSpan(
              text:
                  'If your use of materials from this app results in the need for servicing, repair or correction of equipment or data, you assume any costs thereof will not be responsible for any outcome that may occur during usage of our resources. We reserve the right to change terms and revise the resources usage policy at any moment.\n\n',
            ),
            TextSpan(
              text:
                  'CHOLA Chariots grants you a revocable, non-exclusive, non-transferable, limited license to download, install and use our service strictly following the terms of this agreement. These Terms & Conditions are a contract between you and CHOLA Chariots (referred to in these Terms & Conditions as "CHOLA Chariots", "us", "we" or "our"), the provider of the CHOLA Chariots App and the services accessible from the CHOLA Chariots App (which are collectively referred to in these Terms & Conditions as the "CHOLA Chariots Service").\n\n',
            ),
            TextSpan(
              text:
                  'You agree to be bound by these Terms & Conditions. If you do not agree to these Terms & Conditions, please do not use the Service. In these Terms & Conditions. "You" refers both to you as an individual and to the entity you represent. If you violate any of these Terms & Conditions, we reserve the right to cancel your account or block access to your account without notice.\n\n',
            ),
            TextSpan(
              text:
                  "Thanks for using our services. We appreciate the fact that you like to buy the stuff we build. We also want to make sure you have a rewarding experience while you're exploring evaluating our services. As with any venture, some terms and conditions apply to our company. We will be as brief as our attorneys will allow. The main thing to remember is that you agree to the terms and our Privacy Policy by using our services. If, for any reason, you are not completely satisfied with any service that we provide, don't hesitate to contact us, and we will discuss any of the issues you are going through with our service.\n\n\n\n\n\n\n",
            ),
          ],
        ),
      ),
    );
  }
}
