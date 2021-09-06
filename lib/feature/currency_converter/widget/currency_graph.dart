import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remittance_app/feature/currency_converter/controllers/currency_converter_controller.dart';

class CurrencyConverterGraph extends StatefulWidget {
  CurrencyConverterGraph(this.controller);

  final CurrencyConverterController controller;

  @override
  _CurrencyConverterGraphState createState() => _CurrencyConverterGraphState();
}

class _CurrencyConverterGraphState extends State<CurrencyConverterGraph> {
  @override
  void initState() {
    loadCurrencyTrendData();
    super.initState();
  }

  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
        color: Color(0xFF313865),
        child: Column(
          children: [
            Row(
              children: widget.controller.currencyRateTrendList
                  .asMap()
                  .map((i, e) => MapEntry(
                      i,
                      InkWell(
                        onTap: () {
                          setState(() {
                            sectionIndex = i;
                          });
                          calculateSpots();
                        },
                        child: _graphTiltleSelector(
                            e.trendPeriodTitle, sectionIndex == i),
                      )))
                  .values
                  .toList(),
            ),
            SizedBox(height: 30),
            Container(
              // width: double.infinity,
              height: 250,
              child: LineChart(
                sampleData(),
                // swapAnimationDuration: const Duration(milliseconds: 350),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _graphTiltleSelector(String title, bool isSelectedPoint) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelectedPoint ? Colors.white : Colors.transparent),
              ),
            )
          ],
        ),
      );

  LineChartData sampleData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
              color: const Color.fromARGB(255, 98, 95, 161),
              strokeWidth: 1,
              dashArray: [4, 4]);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 33,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xFFE14F47),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
            }
            return getXaxis(value);
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          getTitles: (value) {
            return getXaxisValue(value);
          },
          margin: 15,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFE14F47),
            width: 1,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: -0.2,
      maxX: maxX,
      maxY: maxY + 1,
      minY: 0,
      lineBarsData: linesBarData1(),
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(color: const Color(0xffA9A9A9), strokeWidth: 1),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 8,
                  color: Colors.blue,
                  strokeWidth: 5,
                  strokeColor: Colors.white,
                ),
              ),
            );
          }).toList();
        },
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> lineBarSpot) {
              return lineBarSpot.map((lineBarSpot) {
                return LineTooltipItem(
                    lineBarSpot.x.toString() + ', ' + lineBarSpot.y.toString(),
                    TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold));
              }).toList();
            },
            tooltipRoundedRadius: 10,
            tooltipBgColor: Color(0xFFF9F9F9),
            tooltipPadding: EdgeInsets.all(10),
            fitInsideHorizontally: true,
            fitInsideVertically: true),
        // touchCallback: (_,LineTouchResponse response) {

        // },
        handleBuiltInTouches: true,
      ),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: [
        const Color(0xff4af699),
        const Color(0xffffffff),
        const Color(0xFF0091FF),
        const Color(0xFFE14F47),
        const Color(0xFFF9F9F9),
      ],
      colorStops: [
        0.0,
        0.5,
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
          radius: 1,
          color: Colors.blue,
          strokeWidth: 1,
          strokeColor: Colors.white,
        ),
      ),
    );
    return [
      lineChartBarData1,
    ];
  }

  /// model value create
  String chartDisplayFormat = 'dd MM';

  List<FlSpot> spots = [FlSpot(0, 0)];
  double maxX = 0;
  double maxY = 0;

  double scale = 1;
  double? smallest;
  double? largest;

  void loadCurrencyTrendData() async {
    calculateSpots();
    calculateXyCount();

    switch (_currencyTrendFilter) {
      case CurrencyTrendFilterType.oneWeek:
      case CurrencyTrendFilterType.threeMonth:
      case CurrencyTrendFilterType.oneMonth:
        chartDisplayFormat = 'dd MMM';
        break;
      default:
    }
  }

  void calculateSpots() {
    var v = widget.controller.currencyRateTrendList[sectionIndex].trendItemList
        .map((f) => f.currencyRate)
        .toList();
    v.sort();
    var count = widget.controller.currencyRateTrendList[sectionIndex]
            .trendItemList.length -
        1;
    var largest = v[v.length - 1];
    var smallest = v[0];

    var diffrence = largest - smallest;

    var scale = diffrence / count;
    this.scale = (scale == 0.0 ? 1 : scale);

    smallest = smallest - scale;

    this.smallest = smallest;
    this.largest = largest;

    double x = 0;
    spots.clear();

    for (var item in widget
        .controller.currencyRateTrendList[sectionIndex].trendItemList) {
      double y = (item.currencyRate - smallest) / this.scale;
      spots.add(FlSpot(x, y));
      x++;
    }
    setState(() {});
    print('L:$largest-S:$smallest');
  }

  void calculateXyCount() {
    maxX = widget
        .controller
        .currencyRateTrendList[sectionIndex]
        .trendItemList
        // .where((item) => item.currencyValueDateShowGraph)
        .length
        .toDouble();
    maxY = widget
        .controller
        .currencyRateTrendList[sectionIndex]
        .trendItemList
        //.where((item) => item.currencyValueShowGraph)
        .length
        .toDouble();
  }

  String getXaxisValue(double value) {
    return ((smallest ?? 0) + ((scale) * value)).toStringAsFixed(3);
  }

  String? _currencyCode;

  CurrencyTrendFilterType _currencyTrendFilter =
      CurrencyTrendFilterType.oneWeek;

  set currencyTrendFilter(CurrencyTrendFilterType value) {
    _currencyTrendFilter = value;
  }

  set currencyCode(String value) {
    _currencyCode = value;
  }

  String getXaxis(double value) {
    if (value > -1)
      return DateFormat(chartDisplayFormat).format(DateTime.parse(widget
          .controller
          .currencyRateTrendList[sectionIndex]
          .trendItemList[value.toInt()]
          .dateTime));
    return ' ';
  }
}

enum CurrencyTrendFilterType { oneWeek, oneMonth, threeMonth }

class CurrencyTrendsMonthFilterModel {
  CurrencyTrendFilterType _currencyTrendFilterType =
      CurrencyTrendFilterType.oneWeek;

  get currencyTrendCurrentFilterType => _currencyTrendFilterType;

  set currencyTrendCurrentFilterType(value) {
    _currencyTrendFilterType = value;
  }
}
