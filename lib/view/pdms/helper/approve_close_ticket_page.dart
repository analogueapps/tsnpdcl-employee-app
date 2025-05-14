import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/pdms/model/inspection_ticket_entity.dart';

class ApproveCloseTicketPage extends StatefulWidget {
  final InspectionTicketEntity inspectionTicketEntity;

  const ApproveCloseTicketPage({super.key, required this.inspectionTicketEntity});

  @override
  State<ApproveCloseTicketPage> createState() => _ApproveCloseTicketPageState();
}

class _ApproveCloseTicketPageState extends State<ApproveCloseTicketPage> {
  final TextEditingController approveQtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: Colors.teal[700],
            width: double.infinity,
            child: const Text(
              "APPROVE & CLOSE TICKET",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Body Scrollable
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Column(
                  children: [
                    _buildInfoRow("TICKET NO", checkNull(widget.inspectionTicketEntity.ticketId.toString())),
                    _buildDivider(),
                    _buildInfoRow("P.O NO", checkNull(widget.inspectionTicketEntity.purchaseOrderNo.toString())),
                    _buildDivider(),
                    _buildInfoRow("Offered Quantity", checkNull(widget.inspectionTicketEntity.qtyForInspection.toString())),
                    _buildInfoRow("Passed Quantity", checkNull(widget.inspectionTicketEntity.passedQuantity.toString()),
                        color: Colors.green, isBold: true),
                    _buildInfoRow("Failed Quantity", checkNull(widget.inspectionTicketEntity.failedQuantity.toString()),
                        color: Colors.red, isBold: true),
                    _buildInfoRow("Tested Quantity", checkNull(widget.inspectionTicketEntity.testedQuantity.toString())),
                    _buildDivider(),

                    // Card instruction
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: const Color(0xFFFFF3CD),
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Please enter the approved quantity below. If test results not satisfactory, Please enter Zero(0) and close the ticket or please enter the quantity you want to approve.",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Approved Qty",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: approveQtyController,
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      decoration: const InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      ),
                    ),
                    _buildDivider(),

                    const SizedBox(height: 15),

                    // Buttons
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
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              final approvedQty = approveQtyController.text;
                              Navigator.pop(context, approvedQty);
                            },
                            child: const Text("Close Ticket"),
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

  Widget _buildDivider() {
    return const Divider(color: Color(0xFFEEEEEE), height: 20);
  }

  Widget _buildInfoRow(String label, String value,
      {Color? color, bool isBold = false}) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        const VerticalDivider(width: 1, color: Color(0xFFEEEEEE)),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: color ?? Colors.black,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
