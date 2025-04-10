import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/viewmodel/failure_individula_viewmodel.dart';

class IndividualFailureReport extends StatelessWidget {
  static const id = Routes.failureIndividual;

  const IndividualFailureReport({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IndividualFailureReportViewModel(context: context),
      child: Consumer<IndividualFailureReportViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Reg No. ${viewModel.report.regNo}',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue,
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  onPressed: viewModel.onFolderPressed,
                  icon: const Icon(Icons.folder_outlined),
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  children: [
                    _buildTableSection(
                      title: '',
                      rows: [
                        _buildTableRow('Registration No.', viewModel.report.regNo,
                            valueColor: Colors.red),
                      ],
                    ),
                    _buildTableSection(
                      title: 'SERVICE DETAILS',
                      rows: [
                        _buildTableRow('HT SCNo.', viewModel.report.htScNo),
                        _buildTableRow(
                            'Village/Distribution', viewModel.report.village),
                        _buildTableRow('Service Name', viewModel.report.serviceName),
                        _buildTableRow('Circle', viewModel.report.circle),
                        _buildTableRow('Division', viewModel.report.division),
                        _buildTableRow('Sub Division', viewModel.report.subDivision),
                        _buildTableRow('Section Code', viewModel.report.sectionCode),
                        _buildTableRow('Section', viewModel.report.section),
                      ],
                    ),
                    _buildTableSection(
                      title: 'FAILED CT PT DETAILS',
                      rows: [
                        _buildTableRow('Make', viewModel.report.make),
                        _buildTableRow('Serial No.', viewModel.report.serialNo),
                        _buildTableRow('M.F', viewModel.report.mf),
                        _buildTableRow('CT PT Ratio', viewModel.report.ctPtRatio),
                        _buildTableRow('Year of Manufactured',
                            viewModel.report.yearManufactured),
                      ],
                    ),
                    _buildTableSection(
                      title: '',
                      rows: [
                        _buildTableRow('Report Status', viewModel.report.status),
                        _buildTableRow('Remarks', viewModel.report.remarks),
                        _buildTableRow('Report Date', viewModel.report.reportDate),
                        _buildTableRow('Report Month/Year',
                            viewModel.report.reportMonthYear),
                        _buildTableRow(
                            'Reported AE Emp Id', viewModel.report.reportedAeEmpId),
                        _buildTableRow('ADE/OP Confirmed Date',
                            viewModel.report.adeOpConfirmedDate),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTableSection({required String title, required List<TableRow> rows}) {
    return Column(
      children: [
        if (title.isNotEmpty)
          Container(
            width: double.infinity,
            color: Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        Table(
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey.shade400, width: 1),
            verticalInside: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
          },
          children: rows,
        ),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value, {Color? valueColor}) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: valueColor),
            ),
          ),
        ),
      ],
    );
  }
}