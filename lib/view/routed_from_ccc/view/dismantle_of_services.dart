import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/viewmodel/dismantle_of_services_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';

class DismantleOfServices extends StatelessWidget {
  static const id = Routes.dismantleOfServices;
   DismantleOfServices({super.key, required this.args});
  Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title:  const Text(
        "Dismantle of Service",
        style:  TextStyle(
        color: Colors.white,
        fontSize: toolbarTitleSize,
        fontWeight: FontWeight.w700,
    ),
    ),
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    ),
    body:ChangeNotifierProvider(
    create: (_) => DismantleOfServicesViewmodel(context: context, args: args),
    child: Consumer<DismantleOfServicesViewmodel>(
    builder: (context, viewModel, child) {
      return Padding(
        padding: const EdgeInsets.all(doubleEleven),
        child: Column(
          children: [
            FillTextFormField(controller: viewModel.uscNo,
              labelText: "Enter USCNO",
              keyboardType: TextInputType.number),
            const Align(
            alignment: Alignment.bottomRight,
            child: TextButton(onPressed: null, child: Text("Fetch Details", style: TextStyle(color:Colors.indigo),),),
            ),
             Container(
              width: double.infinity,
              height: 40,
              color: Colors.blueGrey[50],
              child: const  Center(child:Text("CONSUMER DETAILS"),),
            ),
        ],
        ),
      );
    }
    ),
    ),
    );
  }
}
