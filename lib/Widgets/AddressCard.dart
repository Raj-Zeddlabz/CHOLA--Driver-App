import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final Color color;
  final String address;
  final String locality;

  const AddressCard({
    Key? key,
    required this.color,
    required this.address,
    required this.locality,
  }) : super(key: key);

  @override
    /// Builds the widget tree for the address card.
  ///
  /// The [context] parameter is the build context of the widget.
  /// Returns a [Widget] representing the address card.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color ?? Color(0xffC6BFFF),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Color(0xff424242),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locality ?? 'Unknown Locality',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: MediaQuery.of(context).size.shortestSide * 0.05,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.001,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            address ?? 'No address provided',
                            style: TextStyle(
                              color: Color(0xff2B2424),
                              fontSize: MediaQuery.of(context).size.shortestSide * 0.04,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip, // Ensure text is clipped
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Column(
                  children: [
                    Icon(Icons.star_border),
                    Icon(Icons.bookmark_border),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
