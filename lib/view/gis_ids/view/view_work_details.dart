import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/gis_ids/viewModel/view_work_viewmodel.dart';



class ViewWorkDetails extends StatelessWidget {
  static const id = Routes.viewWorkScreen;
  const ViewWorkDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkDetailsPage();
  }
}

class WorkDetailsPage extends StatelessWidget {
  const WorkDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkDetailsViewModel(context: context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('View Work Details'),
          backgroundColor: Colors.blue,
          leading: Consumer<WorkDetailsViewModel>(
            builder: (context, viewModel, child) => IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => viewModel.close(context),
            ),
          ),
          actions: [
            Consumer<WorkDetailsViewModel>(
              builder: (context, viewModel, child) => IconButton(
                icon: const Icon(Icons.folder_outlined, color: Colors.white),
                onPressed: viewModel.openFolder,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Consumer<WorkDetailsViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTwoColumnTable(viewModel.data),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      color: Colors.grey.shade300,
                      child: const Text(
                        'NOW PROPOSED DETAILS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        'https://via.placeholder.com/150', // Placeholder URL; replace with actual logic
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text('Image not available'));
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'PHOTO',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 21),
                    _buildTwoColumnTable(viewModel.data),
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton: Consumer<WorkDetailsViewModel>(
          builder: (context, viewModel, child) => FloatingActionButton(
            onPressed: viewModel.edit,
            child: const Icon(Icons.edit),
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTwoColumnTable(List<Map<String, String>> data) {
    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      children: data.map((item) {
        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['label'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['value'] ?? '',
                softWrap: true,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}