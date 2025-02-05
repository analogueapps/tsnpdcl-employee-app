import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/reports/model/bar_graph_data.dart';

class LineGraphWidget extends StatelessWidget {
  final BarGraphData graphData;

  const LineGraphWidget({super.key, required this.graphData});

  @override
  Widget build(BuildContext context) {

    if (graphData.lineGraphData == null) {
      return const SizedBox();
    }
    // Build a list of FlSpot lists—one for each dataset.
    List<LineChartBarData> lineBarsData = graphData.lineGraphData!.lineDataSets!.map((dataSet) {
      List<FlSpot> spots = dataSet.lineDataList!
          .map((d) => FlSpot(d.x!, d.y!))
          .toList();
      return LineChartBarData(
        spots: spots,
        isCurved: false,
        color: Colors.primaries[
        graphData.lineGraphData!.lineDataSets!.indexOf(dataSet) %
            Colors.primaries.length],
        barWidth: 1,
        dotData: const FlDotData(show: false),
      );
    }).toList();

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(graphData.title!,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  lineBarsData: lineBarsData,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < graphData.xAxisValues!.length) {
                            return Text(graphData.xAxisValues![index],
                                style: const TextStyle(fontSize: 12));
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Colors.grey,
                          strokeWidth: 1,
                          dashArray: null,
                        );
                      },
                    getDrawingVerticalLine: (value) {
                      return const FlLine(
                        color: Colors.grey,
                        strokeWidth: 1,
                        dashArray: null,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
