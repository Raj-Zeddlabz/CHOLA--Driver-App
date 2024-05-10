import 'package:flutter/material.dart';

class CustomDropdown1 extends StatelessWidget {
  final List<String> items;
  final String value;
  final ValueChanged<String?> onChanged;
  final Widget? prefixIcon;

  const CustomDropdown1({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.prefixIcon,
  }) : super(key: key);

  @override
  /// Builds the widget tree for the dropdown button form field.
///
/// The [context] parameter is the build context of the widget.
///
/// Returns a [DropdownButtonFormField] widget that represents the dropdown
/// button form field.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Default value if the provided value is not in the items list
    final defaultValue = items.contains(value) ? value : items.first;

    return DropdownButtonFormField<String>(
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
        color: Colors.black,
      ),
      value: defaultValue,
      isExpanded: true,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.001,
        ),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: SizedBox(
            height: size.height * 0.06,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.shortestSide * 0.04,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
