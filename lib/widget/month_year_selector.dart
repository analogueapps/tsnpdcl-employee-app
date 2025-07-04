import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class MonthYearSelector extends StatefulWidget {
  static const id = Routes.monthYearSelector;
  final String? onlyWrongCatConfirm;

  const MonthYearSelector({super.key, this.onlyWrongCatConfirm});

  @override
  State<MonthYearSelector> createState() => _MonthYearSelectorState();
}

class _MonthYearSelectorState extends State<MonthYearSelector> {

  String? _selectedMonth;
  int? _selectedYear;

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  late List<int> years;
  late int currentYear;

  @override
  void initState() {
    super.initState();
    currentYear = DateTime.now().year;
    years =
        List.generate(currentYear - 2017 + 1, (index) => currentYear - index);

    int currentMonthIndex = DateTime.now().month - 1;
    _selectedMonth = months[currentMonthIndex];
    _selectedYear = currentYear;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.monthYear.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: () {
              if (_selectedMonth != null && _selectedYear != null) {
                // Return the selected month and year as a Map
                Navigator.pop(context, {
                  'month': _selectedMonth,
                  'year': _selectedYear,
                });

              } else {
                // Optional: Show a message if no selection is made
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a month and year'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Month',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 3,
              children: months.map((month) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMonth = month;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          _selectedMonth == month ? Colors.blue : Colors.white,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        month,
                        style: TextStyle(
                          color: _selectedMonth == month
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Year',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: years.length,
                itemBuilder: (context, index) {
                  final year = years[index];
                  final isSelected = _selectedYear == year;

                  return InkWell(
                    key: ValueKey(year),
                    onTap: () {
                      setState(() {
                        _selectedYear = year;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      color: isSelected ? Colors.green.withOpacity(0.3) : null,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            year.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          if (isSelected)
                            const Icon(Icons.check,
                                color: Colors.green, size: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
