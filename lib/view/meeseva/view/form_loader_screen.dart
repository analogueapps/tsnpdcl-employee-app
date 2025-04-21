import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/meeseva/viewmodel/form_loader_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';

class FormLoaderScreen extends StatelessWidget {
  static const id = Routes.formLoaderScreen;
  final Map<String, dynamic> data;
  const FormLoaderScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormLoaderViewmodel(context: context, data: data),
      child: Consumer<FormLoaderViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                data['regNum'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              // actions: <Widget>[
              //   IconButton(
              //     icon: const Icon(Icons.refresh),
              //     onPressed: () async {
              //       viewModel.loadApplications();
              //     },
              //   ),
              // ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.cscTscApplicationResponse == null
                ? const Center(child: Text("No data founded."),)
            : ListView.builder(
              itemCount: viewModel.cscTscApplicationResponse!.rowList!.length,
              itemBuilder: (context, index) {
                final item = viewModel.cscTscApplicationResponse!.rowList![index];
                if (item.headerBar != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Color(int.parse(item.headerBar!.backGroundColor!.replaceAll('#', '0xFF'))),
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          item.headerBar!.label!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(int.parse(item.headerBar!.labelColor!.replaceAll('#', '0xFF'))),
                          ),
                        ),
                      ),
                      if (item.id == "photoUrl" || item.rowType == 1) ...[
                        const SizedBox(height: 12),
                        Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                              image: item.displayValue != null && item.displayValue!.isNotEmpty
                                  ? DecorationImage(
                                image: NetworkImage(item.displayValue!),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: item.displayValue == null || item.displayValue!.isEmpty
                                ? const Icon(Icons.person, size: 60, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ],
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 10.0,),
                          Expanded(
                            child: Text(
                              item.label ?? '',
                              style: TextStyle(
                                color: Color(int.parse(item.labelColor?.replaceAll('#', '0xFF') ?? '0xFF000000')),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          Expanded(
                            child: Text(
                              item.displayValue ?? '',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(int.parse(item.valueColor?.replaceAll('#', '0xFF') ?? '0xFF000000')),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          color: const Color(0x70000000),
                          child: const Text(
                            "Add Remarks/Reject",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        FloatingActionButton(
                          heroTag: 'fab1',
                          onPressed: () {
                            viewModel.remarkRejectClicked();
                          },
                          backgroundColor: const Color(0x80FF0000),
                          mini: true,
                          child: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    //const SizedBox(height: 20),
                    // FloatingActionButton(
                    //   heroTag: 'fabMain',
                    //   onPressed: () {
                    //     // Add onPressed logic
                    //   },
                    //   backgroundColor: const Color(0x800000FF),
                    //   child: const Icon(Icons.edit),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
