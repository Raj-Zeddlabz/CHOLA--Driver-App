import 'package:flutter/material.dart';

class DobField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final double vertical;
  final double horizontal;
  final Icon? icon;
  final Icon? suffixicon;
  final String? snackbarText;
  final bool? isEditable;
  final Color? color;
  final int? flex;
  final TextEditingController dobController;

  DobField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.vertical,
    required this.horizontal,
    this.snackbarText,
    this.icon,
    this.suffixicon,
    this.color,
    this.flex,
    this.isEditable,
    required this.dobController,
  }) : super(key: key);

  @override
  _DobFieldState createState() => _DobFieldState();
}

class _DobFieldState extends State<DobField> {
  DateTime? selectedDate;
    /// Selects a date using the `showDatePicker` method and updates the selected date and dobController text.
    ///
    /// The function takes a `BuildContext` as a parameter and returns a `Future<void>`.
    ///
    /// The `showDatePicker` method is used to display a date picker dialog and allows the user to select a date.
    /// The `context` parameter is used to build the dialog.
    /// The `initialDate` parameter is set to the current date.
    /// The `firstDate` parameter is set to January 1, 1900.
    /// The `lastDate` parameter is set to the current date.
    ///
    /// If a date is selected and it is different from the current selected date,
    /// the selected date is updated and the dobController text is set to the selected date in the format "YYYY-MM-DD".
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
    // Builds the Date of Birth TextFormField Widget with various input decoration settings and validation.
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex ?? 1,
      child: TextFormField(
        controller: widget.dobController,
        onTap: () => _selectDate(context),
        readOnly: true,
        decoration: InputDecoration(
          suffixIcon: widget.suffixicon,
          enabled: widget.isEditable ?? true,
          filled: true,
          fillColor: Colors.white,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            // color: widget.color ?? ThemeData.light().colorScheme.primary,
            fontWeight: FontWeight.w900,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
          hintText: widget.hintText,
          icon: widget.icon,
          contentPadding: EdgeInsets.symmetric(
            vertical:
                MediaQuery.of(context).size.shortestSide * widget.vertical,
            horizontal:
                MediaQuery.of(context).size.shortestSide * widget.horizontal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.snackbarText;
          }
          return null;
        },
      ),
    );
  }
}
