import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/reports/model/bar_graph_data.dart';

class GroupedBarGraphWidget extends StatelessWidget {
  final BarGraphData graphData;

  const GroupedBarGraphWidget({super.key, required this.graphData});

  @override
  Widget build(BuildContext context) {
    // Create one BarChartGroupData for each xAxis value.
    // In this example, we assume multiple data sets are to be grouped.
    if (graphData.barEntryDataList == null) {
      return const SizedBox();
    }

    // Determine the number of groups from the xAxis labels.
    final int groupCount = graphData.xAxisValues!.length;
    // Build data for each dataset.
    List<BarChartGroupData> groups = List.generate(groupCount, (i) {
      // For each group, collect the y-values from each data set.
      List<BarChartRodData> rods = [];
      for (var dataSet in graphData.barEntryDataList!) {
        // Look for the bar entry matching the group index.
        // (Assumes x values start at 1 and are sequential.)
        BarEntriesList? entry = dataSet.barEntriesList!.firstWhere(
            (e) => e.x!.toInt() == i + 1,
            orElse: () => BarEntriesList(x: i.toDouble(), y: 0));
        rods.add(BarChartRodData(
          toY: entry.y!,
          width: 10,
          color: Colors.primaries[graphData.barEntryDataList!.indexOf(dataSet) %
              Colors.primaries.length],
        ));
      }
      return BarChartGroupData(x: i, barRods: rods);
    });

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
              child: BarChart(
                duration: const Duration(milliseconds: 150),
                curve: Curves.slowMiddle,
                BarChartData(
                  barGroups: groups,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 &&
                              index < graphData.xAxisValues!.length) {
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
