import 'package:flutter/material.dart';

class DocumentButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isVerify;
  final bool isEnable;
  const DocumentButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isVerify,
    required this.isEnable,
  });

  @override
  State<DocumentButton> createState() => _DocumentButtonState();
}

class _DocumentButtonState extends State<DocumentButton> {
  @override
      /// Builds the widget tree for this widget.
    ///
    /// The [context] parameter is the build context for this widget.
    ///
    /// Returns the widget tree for this widget.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.01,
      ),
      child: Container(
        width: size.width,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return Colors.white;
              },
            ),
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.03,
              ),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide(
                  width: (widget.isVerify) ? 5 : 1,
                  color: (widget.isVerify) ? Color(0xff15AD2D) : Colors.black,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            elevation: MaterialStatePropertyAll(5.0),
          ),
          onPressed: (widget.isEnable) ? widget.onPressed : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: size.shortestSide * 0.05,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              (widget.isVerify)
                  ? Icon(
                      Icons.verified_rounded,
                      color: Colors.green,
                      size: size.shortestSide * 0.09,
                    )
                  : Transform.rotate(
                      angle: 90 * (3.141592653589793 / 180),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.navigation_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
