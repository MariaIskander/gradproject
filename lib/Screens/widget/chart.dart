import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarChart(),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
          toY: y,
          width: 13,
          backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 5,
              gradient: const LinearGradient(
                  colors: [Color(0xFF124559), Color(0xff598392),Color(0xffAEC3B0)])))
    ]);
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 2);
          case 1:
            return makeGroupData(1, 3);
          case 2:
            return makeGroupData(2, 2);
          case 3:
            return makeGroupData(3, 4.5);
          case 4:
            return makeGroupData(4, 3.8);
          case 5:
            return makeGroupData(5, 1.5);
          case 6:
            return makeGroupData(6, 4);
            default : 
            return throw Error();
        }
      });

  BarChartData mainBarChart() {
    return BarChartData(
      titlesData: FlTitlesData(
          show: true,
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: getTiles,
          )),
          leftTitles:
               AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 35,
            getTitlesWidget: leftTiles,))),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: showingGroups(),
    );
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF124559),
      fontSize: 15,
      fontFamily: 'Cambo',
      fontWeight: FontWeight.w500,
      height: 0,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('S', style: style);
        break;
      case 1:
        text = const Text('M', style: style);
        break;
      case 2:
        text = const Text('T', style: style);
        break;
      case 3:
        text = const Text('W', style: style);
        break;
      case 4:
        text = const Text('Th', style: style);
        break;
      case 5:
        text = const Text('F', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, space: 15, child: text);
  }

  Widget leftTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF124559),
      fontSize: 15,
      fontFamily: 'Cambo',
      fontWeight: FontWeight.w500,
    );
    String text;
    if (value == 0) {
      text = '0h';
    } else if (value == 6) {
      text = '18h';
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }
}
