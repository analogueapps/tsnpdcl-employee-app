import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthYearSelector extends StatefulWidget {
  @override
  _MonthYearSelectorState createState() => _MonthYearSelectorState();
}

class _MonthYearSelectorState extends State<MonthYearSelector> {
  String? _selectedMonth;
  int? _selectedYear;

  // List of months
  final List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  // List of years starting from 2017
  final List<int> years = List.generate(9, (index) => 2017 + index);

  @override
  void initState() {
    super.initState();
    _selectedMonth = 'Apr'; // Default selected month
    _selectedYear = 2025;   // Default selected year
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Month Year'),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () {
              // Handle save action here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: $_selectedMonth $_selectedYear')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Close the dialog or screen
            },
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Month',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: months.map((month) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMonth = month;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedMonth == month ? Colors.blue : Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          month,
                          style: TextStyle(
                            color: _selectedMonth == month ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select Year',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: years.length,
                itemBuilder: (context, index) {
                  final year = years[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedYear = year;
                      });
                    },
                    child: Container(
                      color: _selectedYear == year ? Colors.green.withOpacity(0.3) : null,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            year.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          if (_selectedYear == year)
                            Icon(Icons.check, color: Colors.green, size: 16),
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
// Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MonthYearSelector()));