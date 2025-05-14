import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';
import 'package:tsnpdcl_employee/view/pdms/model/inspection_ticket_entity.dart';

class AssignInspectionOfficerPage extends StatefulWidget {
  final List<OptionList> inspectionOfficers;
  final InspectionTicketEntity inspectionTicketEntity;

  const AssignInspectionOfficerPage({super.key, required this.inspectionTicketEntity, required this.inspectionOfficers});

  @override
  _AssignInspectionOfficerPageState createState() => _AssignInspectionOfficerPageState();
}

class _AssignInspectionOfficerPageState extends State<AssignInspectionOfficerPage> {
  OptionList? selectedOfficer;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: Colors.blue.shade900, // Replace with your deep_blue color
            child: const Center(
              child: Text(
                "ASSIGN INSPECTION OFFICER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  
                ),
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRow("TICKET NO", checkNull(widget.inspectionTicketEntity.ticketId.toString())),
                    divider(),
                    buildRow("P.O NO", checkNull(widget.inspectionTicketEntity.purchaseOrderNo.toString())),
                    divider(),
                    buildRow("Test Quantity", checkNull(widget.inspectionTicketEntity.qtyForInspection.toString())),
                    divider(),

                    // Select Officer
                    const SizedBox(height: 10),
                    const Text(
                      "Select Officer",
                      style: TextStyle(
                        
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<OptionList>(
                      value: selectedOfficer,
                      items: widget.inspectionOfficers.map((OptionList value) {
                        return DropdownMenuItem<OptionList>(
                          value: value,
                          child: Text(value.optionName!),
                        );
                      }).toList(),
                      onChanged: (OptionList? newValue) {
                        setState(() {
                          selectedOfficer = newValue!;
                        });
                      },
                    ),
                    divider(),
                    const SizedBox(height: 10),
                    const Text(
                      "Schedule Date",
                      style: TextStyle(
                        
                        color: Colors.black,
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Colors.blue,
                          onPrimary: Colors.green,
                          surface: Colors.green,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 2)), // current date + 2 years
                        onDateChanged: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    ),
                    divider(),

                    // Buttons
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "CANCEL",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // success_green
                            ),
                            onPressed: () {
                              if(selectedOfficer != null) {
                                DateTime zeroedDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                );
                                int scheduleDateInMillis = zeroedDate.millisecondsSinceEpoch;
                                final args = {
                                  "empId": selectedOfficer!.optionId,
                                  "scheduleDate": scheduleDateInMillis,
                                };
                                Navigator.pop(context, args);
                              } else {
                                showAlertDialog(context, "Please select an officer.");
                              }
                            },
                            child: const Text(
                              "ASSIGN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(width: 1, height: 30, color: Colors.grey.shade300),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            constraints: const BoxConstraints(minHeight: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget divider() {
    return Container(
      height: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}
