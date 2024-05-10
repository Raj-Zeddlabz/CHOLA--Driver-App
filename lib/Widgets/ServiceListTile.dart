import 'package:chola_driver_flutter/Constants/Constants.dart';
import 'package:flutter/material.dart';

class ServiceListTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;
  final String imagePath;

  const ServiceListTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.imagePath,
  }) : super(key: key);

  @override
    /// Builds the widget tree for this widget based on the given [BuildContext].
  ///
  /// The [context] parameter is the build context for this widget.
  ///
  /// Returns the widget tree for this widget.
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: ListTile(
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: size.shortestSide * 0.05,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Image.asset(
          imagePath,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        splashColor: Theme.of(context).colorScheme.onBackground,
        trailing: Transform.scale(
          scale: 0.8,
          child: Switch(
            thumbColor:
                MaterialStatePropertyAll(value ? Colors.green : Colors.red),
            trackColor:
                MaterialStatePropertyAll(value ? Colors.white : Colors.white),
            trackOutlineColor:
                MaterialStatePropertyAll(value ? Colors.green : Colors.red),
            splashRadius: size.width * 0.1,
            value: value,
            onChanged: (value) {
              Constants.showError(context,
                  "Stay Tuned for an Exciting Addition! We're thrilled to announce a new feature coming your way!");
            },
          ),
        ),
      ),
    );
  }
}
