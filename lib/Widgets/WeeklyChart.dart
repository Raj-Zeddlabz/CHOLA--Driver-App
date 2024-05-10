import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TimeSeriesBar extends StatefulWidget {
  final List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
  final bool? animate;

  TimeSeriesBar(this.seriesList, {this.animate});

  factory TimeSeriesBar.withSampleData() {
    return TimeSeriesBar(
      _createSampleData(),
      animate: true,
    );
  }
  @override
  State<TimeSeriesBar> createState() => _TimeSeriesBarState();

  // Generates sample data for a time series chart.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final today = DateTime.now();
    final last7Days =
        List.generate(7, (index) => today.subtract(Duration(days: index)));

    final data = [
      TimeSeriesSales(last7Days[6], 5),
      TimeSeriesSales(last7Days[5], 5),
      TimeSeriesSales(last7Days[4], 250),
      TimeSeriesSales(last7Days[3], 100),
      TimeSeriesSales(last7Days[2], 75),
      TimeSeriesSales(last7Days[1], 88),
      TimeSeriesSales(last7Days[0], 65),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class _TimeSeriesBarState extends State<TimeSeriesBar> {
      /// Formats a given [DateTime] object into a string representation of the date.
    ///
    /// The function takes a [DateTime] object as input and returns a string
    /// representation of the date in the format "DDth/ND/RD MMMM". The day of the
    /// month is appended with the appropriate suffix (st, nd, rd, or th) based
    /// on its value. The month name is obtained by calling the private function
    /// [_getMonthName].
    ///
    /// Returns a string representation of the formatted date.
  String _formatDate(DateTime date) {
    String suffix = 'th';
    if (date.day == 1 || date.day == 21 || date.day == 31) {
      suffix = 'st';
    } else if (date.day == 2 || date.day == 22) {
      suffix = 'nd';
    } else if (date.day == 3 || date.day == 23) {
      suffix = 'rd';
    }

    return '${date.day}$suffix ${_getMonthName(date.month)}';
  }
  /// Returns the name of the month corresponding to the given [month] integer.
  ///
  /// The [month] parameter should be an integer between 1 and 12, representing
  /// the month number. Returns the name of the month as a string. If the
  /// [month] parameter is not between 1 and 12, an empty string is returned.
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
  // Builds the main UI widget for displaying a time series chart with various configurations.
  @override
  Widget build(BuildContext context) {
    final startDate = widget.seriesList.first.data.first.time;
    final endDate = widget.seriesList.first.data.last.time;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${_formatDate(startDate)} - ${_formatDate(endDate)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.01,
        // ),
        Expanded(
          child: charts.TimeSeriesChart(
            widget.seriesList,
            layoutConfig: charts.LayoutConfig(
              leftMarginSpec: charts.MarginSpec.fromPercent(minPercent: 0),
              topMarginSpec: charts.MarginSpec.defaultSpec,
              rightMarginSpec: charts.MarginSpec.defaultSpec,
              bottomMarginSpec: charts.MarginSpec.defaultSpec,
            ),
            animate: widget.animate,
            animationDuration: Duration(milliseconds: 500),
            defaultRenderer: charts.BarRendererConfig<DateTime>(),
            defaultInteractions: false,
            behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
            domainAxis: charts.DateTimeAxisSpec(
              showAxisLine: true,
              tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
              tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                day: charts.TimeFormatterSpec(
                  format: 'E',
                  transitionFormat: 'E',
                ),
              ),
              renderSpec: charts.GridlineRendererSpec(
                minimumPaddingBetweenLabelsPx: 3,
                axisLineStyle: charts.LineStyleSpec(
                  color: charts.Color.black,
                ),
                labelAnchor: charts.TickLabelAnchor.inside,
                lineStyle: charts.LineStyleSpec(
                  color: charts.Color.fromHex(code: '#a9a9a9'),
                  dashPattern: [4],
                ),
              ),
            ),
            primaryMeasureAxis: charts.NumericAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                minimumPaddingBetweenLabelsPx: 3,
                axisLineStyle: charts.LineStyleSpec(
                  color: charts.Color.black,
                ),
                labelAnchor: charts.TickLabelAnchor.inside,
                lineStyle: charts.LineStyleSpec(
                  color: charts.Color.fromHex(code: '#A9A9A9'),
                  dashPattern: [
                    4
                  ], // Optional: add a dash pattern for the grid line
                ),
              ),
              tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                (num? value) => value != null ? ' INR ${value.toInt()}' : '',
              ),
            ),
            secondaryMeasureAxis: charts.NumericAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                labelStyle: charts.TextStyleSpec(
                  color: charts.Color.fromHex(code: '#A9A9A9'),
                  fontWeight: 'bold',
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
              tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                (num? value) => value != null ? ' INR ${value.toInt()}' : '',
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDataContainer('Total Trips', '140'),
              _buildDataContainer('Time Online', '6d 15h'),
              _buildDataContainer('Total\nDistance', '45 KM'),
            ],
          ),
        ),
      ],
    );
  }
    /// Builds a data container widget with a title and value.
    ///
    /// The data container widget is a flexible widget that contains a container with
    /// rounded corners and a light grey background color. The container has padding
    /// around its content and contains a column of two text widgets. The first text
    /// widget displays the title and is styled with a black color, font size of 14,
    /// font family 'Poppins', font weight w700, and no line height. The second text
    /// widget displays the value and is styled similarly to the first text widget.
    /// Both text widgets have ellipsis overflow behavior.
    ///
    /// Parameters:
    ///   - title: The title of the data container.
    ///   - value: The value of the data container.
    ///
    /// Returns:
    ///   A flexible widget that contains the data container.
  Widget _buildDataContainer(String title, String value) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
