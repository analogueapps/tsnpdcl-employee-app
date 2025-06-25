import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/routed_from_ccc/viewmodel/dismantle_of_services_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class DismantleOfServices extends StatelessWidget {
  static const id = Routes.dismantleOfServices;
   const DismantleOfServices({super.key, required this.args});
  final Map<String, dynamic> args;

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
      return Stack(
          children:[
            SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:doubleEleven, left: doubleEleven,right: doubleEleven, bottom: doubleTwentyFive),
          child: Form(
        key:viewModel.formKey,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FillTextFormField(controller: viewModel.uscNo,
                labelText: "USCNO",
                 isReadOnly: isTrue,
                keyboardType: TextInputType.number),
               Align(
              alignment: Alignment.bottomRight,
              child: TextButton(onPressed:() {
                viewModel.getConsumerWithUscNo(args['uscno']);
              }, child: Text("Fetch Details", style: TextStyle(color:Colors.indigo),),),
              ),
               Container(
                width: double.infinity,
                height: 40,
                 alignment: Alignment.centerLeft,
                color: Colors.blueGrey[50],
                child: const Text("CONSUMER DETAILS", style: TextStyle(color: CommonColors.deepBlue),),
              ),
              const SizedBox(height: doubleTen,),
            Table(
                // border:TableBorder.all(width: 1.5,color:CommonColors.lightGrey),
                border: const TableBorder.symmetric(
                  inside: BorderSide(
                    width: 1.5,
                    color: CommonColors.lightGrey,
                  ),
        
                ),
              columnWidths: const {
                0: FlexColumnWidth(0.4), // 40% of the width
                1: FlexColumnWidth(0.6), // 60% of the width
              },
              children: [
                TableRow(
                  children: [
                    Visibility(
                      visible:viewModel.fetchDetailsClicked==isTrue ,
                      child: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('USCNO'),
                    ),
                    ),
                    TextField(
                      controller: viewModel.consumerWithUscNo,
                      readOnly: true,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),TableRow(
                  children: [
                    Visibility(
                      visible:viewModel.fetchDetailsClicked==isTrue ,
                      child: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('SCNO/CAT'),
                    ),
                    ),
                    TextField(
                      controller: viewModel.consumerWithUscNo,
                      readOnly: true,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),TableRow(
                  children: [
                    Visibility(
                      visible:viewModel.fetchDetailsClicked==isTrue ,
                      child: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('CONSUMER NAME'),
                    ),
                    ),
                    TextField(
                      controller: viewModel.consumerWithUscNo,
                      readOnly: true,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),TableRow(
                  children: [
                    Visibility(
                      visible:viewModel.fetchDetailsClicked==isTrue ,
                      child: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('ADDRESS LINE 1'),
                    ),
                    ),
                    TextField(
                      controller: viewModel.consumerWithUscNo,
                      readOnly: true,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),TableRow(
                  children: [
                     Visibility(
                      visible:viewModel.fetchDetailsClicked==isTrue ,
                      child:const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('ADDRESS LINE 2'),
                    ),
                     ),
                    TextField(
                      controller: viewModel.consumerWithUscNo,
                      readOnly: true,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),TableRow(
                  children: [
                    Visibility(
                      visible:viewModel.fetchDetailsClicked==isTrue ,
                      child: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('ADDRESS LINE 3'),
                    ),
                    ),
                    TextField(
                      controller: viewModel.consumerWithUscNo,
                      readOnly: true,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),TableRow(
                  children: [
                     Visibility(
                      visible:viewModel.fetchDetailsClicked==isTrue ,
                      child: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [Text('ADDRESS LINE 4'),
                      Divider(),
                      ]
                      ),
                    ),
                     ),
                    TextField(
                      controller: viewModel.consumerWithUscNo,
                      readOnly: true,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                ]
            ),
              const SizedBox( height: doubleTen,),
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.blueGrey[50],
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("METER AVAILABLE", style: TextStyle(color: CommonColors.deepBlue),),
                    Switch(
                      value: viewModel.meterAvailableSwitch,
                      onChanged: (value) {
                        viewModel.meterAvailable = value;
                      },
                    ),
                  ],
                ),
              ),
             Visibility(
               visible: viewModel.meterAvailableSwitch==isTrue,
               child:
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
              const Text("MAKE",style: TextStyle(color:  Color(0xff5ba55e)),),
              DropdownButtonFormField<String>(
                value: viewModel.meterMakeName,
                hint:  Text(viewModel.optionNames.isEmpty?"":"SELECT"),
                isExpanded: true,
                items: viewModel.optionNames.map((String name) {
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 1, color: Colors.grey),
                    )),
                onChanged: (newValue) {
                  viewModel.updateOldMeterMake(newValue!);
                },
              ),
              const SizedBox(height: doubleTen,),
              FillTextFormField(controller: viewModel.serialNo, labelText: "SERIAL NO", keyboardType: TextInputType.number),
              const SizedBox(height: doubleTen,),
              FillTextFormField(controller: viewModel.capacity, labelText: "CAPACITY", keyboardType: TextInputType.number),
              const SizedBox(height: doubleTen,),
              Row(children: [
              Expanded(child: FillTextFormField(controller: viewModel.kwh, labelText: "KWH", keyboardType: TextInputType.number)),
              const SizedBox(width: doubleTen,),
                Expanded(child: FillTextFormField(controller: viewModel.kvah, labelText: "KVAH", keyboardType: TextInputType.number)),
                // SizedBox(height: doubleTen,),
              ]
              ),
              const Divider(),
              const Text("Disconnection DATE", style: TextStyle(color:  Color(0xff5ba55e)),),
              TextField(
                controller: viewModel.disconnectionDate,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate); // e.g., "14/04/2025"
                    viewModel.setDate(formattedDate);
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: "TAP HERE",
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              const Divider(),
              ]
             ),
             ),
              const SizedBox(height: doubleTen,),
              const Text("UPLOAD CONSUMER REPRESENTATION", style: TextStyle(color:  Color(
                  0xff5ba55e)),),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: viewModel.fileName),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.upload_file, size: doubleForty,),
                        onPressed: viewModel.pickDocument,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
              const SizedBox(height: doubleTen,),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                    text: "SUBMIT",
                    onPressed: (){
                      viewModel.submitForm();
                    }
                ),
              ),
            ],
          ),
          ),
        ),
      ),
            if(viewModel.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  // Optional: dim background
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
      ]
      );
    }
    ),
    ),
    );
  }
}
