import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:chola_driver_flutter/Pages/AddDocument.dart';
import 'package:chola_driver_flutter/Pages/ComingSoon.dart';
import 'package:flutter/material.dart';

class CardRow1 extends StatelessWidget {
  final List<Color>? colors;
  final double? preferredSizeHeight;

  const CardRow1({Key? key, required this.colors, this.preferredSizeHeight})
      : super(key: key);

  @override
    /// Builds the widget tree for this widget.
  ///
  /// The [context] parameter is the build context for this widget.
  ///
  // /// Returns the widget tree for this widget.
  // Widget build(BuildContext context) {
  //   // ...
  // }
  Widget build(BuildContext context) {
    String cardText1 = 'CHOLA Vehicles';
    String cardText2 = 'CHOLA Rentals';
    String cardText4 = 'CHOLA Shift\n Vehicles';
    String cardText3 = 'OWN Vehicles';
    String cardText5 = 'CONTRACT Vehicles';

    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height - preferredSizeHeight!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildCard(context, 0, cardText1, size),
              _buildCard(context, 1, cardText2, size),
            ],
          ),
          _buildCard1(context, 2, cardText4, size),
          Row(
            children: [
              _buildCard(context, 3, cardText3, size),
              _buildCard(context, 4, cardText5, size),
            ],
          ),
        ],
      ),
    );
  }
  /// Builds a card widget.
  ///
  /// The [context] parameter is the build context.
  /// The [index] parameter is the index of the card.
  /// The [cardText] parameter is the text to display on the card.
  /// The [size] parameter is the size of the card.
  ///
  /// Returns a [Widget] representing the built card.
  Widget _buildCard(
      BuildContext context, int index, String cardText, Size size) {
    return Container(
      height: size.height / 4,
      width: size.width / 2,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.02,
      ),
      child: Material(
        color: colors?[index],
        elevation: 8.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          splashColor: Colors.black26,
          onTap: () {
            if (index == 0 || index == 1 || index == 2 || index == 4) {
              Constants.showError(context,
                  "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDocument(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComingSoon(),
                ),
              );
            }
          },
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              height: size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.005,
                      bottom: size.height * 0.005,
                      left: size.width * 0.01,
                      right: size.width * 0.01,
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: Image.asset(
                        'assets/card_i_${index}.png',
                        fit: BoxFit.fitWidth,
                        height: size.height * 0.16,
                        width: size.width,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            cardText,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: size.width * 0.025,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            color: colors?[index],
                            size: size.height * 0.025,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
    /**
     * Builds a card widget.
     *
     * The [context] parameter is the build context.
     * The [index] parameter is the index of the card.
     * The [cardText] parameter is the text to display on the card.
     * The [size] parameter is the size of the card.
     *
     * Returns a [Widget] representing the built card.
     */
  Widget _buildCard1(
      BuildContext context, int index, String cardText, Size size) {
    return Container(
      height: size.height / 3.7,
      width: size.width / 1.9,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.02,
      ),
      child: Material(
        color: colors?[index],
        elevation: 8.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          splashColor: Colors.black26,
          onTap: () {
            Constants.showError(context,
                "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
          },
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              // height: size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.005,
                      bottom: size.height * 0.005,
                      left: size.width * 0.01,
                      right: size.width * 0.01,
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: Image.asset(
                        'assets/card_i_${index}.png',
                        fit: BoxFit.fitWidth,
                        height: size.height * 0.16,
                        width: size.width,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            cardText,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: size.width * 0.025,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            color: colors?[index],
                            size: size.height * 0.025,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
