import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final TextEditingController controller;
  final List<String> ListOfDropDown;
  // final int flex;
  final String labelText;
  final ValueChanged<String?>? onChanged;
  final Icon? icon;
  final bool? isEditable;
  final Color? color;
  final double vertical;
  final double horizontal;
  final VoidCallback? onTap;

  CustomDropDown({
    required this.controller,
    // required this.flex,
    this.onChanged,
    required this.ListOfDropDown,
    required this.labelText,
    this.icon,
    this.isEditable,
    this.color,
    required this.vertical,
    required this.horizontal,
    this.onTap,
  });

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
    /// Builds the widget tree for the dropdown button form field.
  ///
  /// The [context] parameter is the build context of the widget.
  ///
  /// Returns an [Expanded] widget that contains a [Column] widget with two children:
  /// - If [widget.labelText] is not empty, a [Text] widget displaying the label text.
  /// - A [SizedBox] widget with a height of 1% of the screen height.
  /// - A [GestureDetector] widget wrapping a [DropdownButtonFormField] widget.
  ///
  /// The [DropdownButtonFormField] widget has the following properties:
  /// - [dropdownColor]: Colors.white.
  /// - [isExpanded]: true.
  /// - [value]: The value of [widget.controller.text] if it is not empty, otherwise the first element of [widget.ListOfDropDown].
  /// - [onChanged]: [widget.onChanged].
  /// - [items]: A list of [DropdownMenuItem] widgets generated from [widget.ListOfDropDown].
  /// - [decoration]: An [InputDecoration] widget with the following properties:
  ///   - [filled]: true.
  ///   - [fillColor]: Colors.white.
  ///   - [enabled]: [widget.isEditable] if it is not null, otherwise true.
  ///   - [labelStyle]: A [TextStyle] widget with the following properties:
  ///     - [fontWeight]: FontWeight.w900.
  ///     - [fontSize]: 4.5% of the screen width.
  ///   - [icon]: [widget.icon].
  ///   - [contentPadding]: An [EdgeInsets] widget with vertical and horizontal padding calculated based on the screen size and [widget.vertical] and [widget.horizontal] respectively.
  ///   - [border]: An [OutlineInputBorder] widget with a border radius of 8.0.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      // flex: widget.flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.labelText.length != 0)
              ? Text(
                  widget.labelText,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
          SizedBox(
            height: size.height * 0.01,
          ),
          GestureDetector(
            onTap: widget.onTap,
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              isExpanded: true,
              value: widget.controller.text.isNotEmpty
                  ? widget.controller.text
                  : widget.ListOfDropDown.first,
              onChanged: widget.onChanged,
              items: widget.ListOfDropDown.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ).toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabled: widget.isEditable ?? true,
                // labelText: widget.labelText,
                labelStyle: TextStyle(
                  // color: widget.color ?? ThemeData.light().colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
                icon: widget.icon,
                contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.shortestSide *
                      widget.vertical,
                  horizontal: MediaQuery.of(context).size.shortestSide *
                      widget.horizontal,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
