import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/pmi_inspection_form_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_head_widget.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class PmiInspectionForm extends StatelessWidget {
  const PmiInspectionForm({super.key, required this.args});
  static const id = Routes.pmiInspectionForm;
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            PmiInspectionFormViewmodel(context: context, args: args),
        child: Consumer<PmiInspectionFormViewmodel>(
        builder: (context, viewModel, child) {
    return Scaffold(
    appBar: AppBar(
    backgroundColor: CommonColors.colorPrimary,
    title: Text(
    viewModel.readOnly?"PM ID: ":"pmi entry form".toUpperCase(),
    style: const TextStyle(
    color: Colors.white,
    fontSize: toolbarTitleSize,
    fontWeight: FontWeight.w700),
    ),
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    actions: const [
      IconButton(onPressed: null, icon: Icon(Icons.save_outlined, color: Colors.white,),),
      IconButton(onPressed: null, icon: Icon(Icons.folder_outlined,  color: Colors.white,),),
    ],
    ),
    body:SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: viewModel.formControls.map((control) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (control.headerBar != null)
                  Container(
                    color: viewModel.hexToColor(control.headerBar!.backGroundColor),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      control.headerBar!.label,
                      style: TextStyle(
                        color: viewModel.hexToColor(control.headerBar!.labelColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                viewModel.buildFormField(control),
                SizedBox(height: 16.0),
              ],
            );
          }).toList(),
        ),
      ),
    ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.pinkAccent,
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,),),
    );
    }
        ),
    );
  }
}

