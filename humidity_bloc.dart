
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Data/temperature_bloc.dart';

late List<FlSpot> data = [];
late List<FlSpot> data2 = [];
class LineChartD extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 24,
    maxY: 100,
    minY: 0,
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
  ];



  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0', style: style);
        break;
      case 5:
        text = const Text('5', style: style);
        break;
      case 10:
        text = const Text('10', style: style);
        break;
      case 15:
        text = const Text('15', style: style);
        break;
      case 20:
        text = const Text('20', style: style);
        break;
      case 24:
        text = const Text('24', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: Colors.cyan.withOpacity(0.2), width: 4),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    color: Colors.green,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: data2,
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    color: Colors.pinkAccent,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
      color: Colors.pinkAccent.withOpacity(0),
    ),
    spots: data,
  );



}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  Future<void> createTempData() async {
    List<Map<String, dynamic>> getData  = await getTemperature();
    for(var i = 0; i < 24; i++){
      data.add(FlSpot(i.toDouble(), double.parse( getData[i]['value'])));
    }
   // print(data);

  }
  Future<void> createHumidityData() async {
    List<Map<String, dynamic>> getData  = await getHumidity();
    for(var i = 0; i < 24; i++){
      data2.add(FlSpot(i.toDouble(), double.parse( getData[i]['value'])));
    }
    //print(data2);

  }
  @override
  void initState() {
    super.initState();
    data.clear();
    data2.clear();
    createTempData();
    createHumidityData();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Thống Kê Dữ Liệu'),
          centerTitle: true,
          titleTextStyle: const  TextStyle(fontSize: 30, color: Colors.blueAccent,),
    ),
      body: Padding (
        padding: const EdgeInsets.all(16.0),
        child: LineChartD(),
      ),
    );

  }
}