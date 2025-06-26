import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/name_address_correction/viewmodel/name_create_correspondence_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class NameCreateCorrespondence extends StatelessWidget {
  const NameCreateCorrespondence({super.key});

  static const id = Routes.nameCreateCorrespondence;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title:  Text(
          "name and address correction".toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: titleSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => NameCreateCorrespondenceViewmodel(context: context),
        child: Consumer<NameCreateCorrespondenceViewmodel>(
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
                              const Text("Enter USCNO", style: TextStyle(color:  Color(
                                  0xff5ba55e)),),
                              TextField(
                                  controller: viewModel.uscNo,
                                  maxLength: 8,

                                  keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  counterText: "",
                                  hintText: "USCNO",
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                ),),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(onPressed:() {
                                  if(viewModel.uscNo.text.isEmpty){
                                    AlertUtils.showSnackBar(
                                        context, "Please enter valid USCNO",
                                        isTrue);
                                  }else {
                                    viewModel.getConsumerWithUscNo(
                                        viewModel.uscNo.text);
                                  }
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: doubleEight),
                                          child: TextField(
                                            controller: viewModel.consumerWithUscNo,
                                            readOnly: true,
                                          ),
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: doubleEight),
                                          child: TextField(
                                            controller: viewModel.scNoCat,
                                            readOnly: true,
                                          ),
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: doubleEight),
                                          child: TextField(
                                            controller: viewModel.consumerName,
                                            readOnly: true,
                                          ),
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: doubleEight),
                                          child: TextField(
                                            controller: viewModel.addressLine1,
                                            readOnly: true,
                                          ),
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: doubleEight),
                                          child: TextField(
                                            controller: viewModel.addressLine2,
                                            readOnly: true,
                                          ),
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: doubleEight),
                                          child: TextField(
                                            controller: viewModel.addressLine3,
                                            readOnly: true,
                                          ),
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
                                        Padding(
                                          padding:const EdgeInsets.only(left: doubleEight),
                                          child: TextField(
                                            controller: viewModel.addressLine4,
                                            readOnly: true,
                                          ),
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
                                    const Text("NAME CORRECTION", style: TextStyle(color: CommonColors.deepBlue),),
                                    Switch(
                                      value: viewModel.nameSwitch,
                                      onChanged: (value) {
                                        viewModel.nameAvailable = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: viewModel.nameSwitch==isTrue,
                                child:
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: doubleTen,),
                                      const Text("SURNAME", style: TextStyle(color:  Color(
                                          0xff5ba55e)),),
                                      TextField(
                                        controller: viewModel.surname,
                                        maxLength: 20,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                        ),
                                      ),

                                      const SizedBox(height: doubleTen,),
                                      const Text("NAME", style: TextStyle(color:  Color(
                                          0xff5ba55e)),),
                                      TextField(
                                        controller: viewModel.name,
                                        maxLength: 20,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                        ),
                                      ),
                                      const SizedBox(height: doubleTen,),
                                      const Text("FATHER NAME OR W/O", style: TextStyle(color:  Color(
                                          0xff5ba55e)),),
                                      TextField(
                                        controller: viewModel.fatherNameOrWO,
                                        maxLength: 20,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                        ),
                                      ),
                                        const SizedBox(width: doubleTen,),
                                        ]
                                      )
                                      ),
                                        const SizedBox(height: doubleTen,),
                                      const Divider(),
                                      Container(
                                        width: double.infinity,
                                        height: 40,
                                        color: Colors.blueGrey[50],
                                        alignment: Alignment.centerLeft,
                                        child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            const Text("ADDRESS CORRECTION", style: TextStyle(color: CommonColors.deepBlue),),
                                            Switch(
                                            value: viewModel.addressSwitch,
                                            onChanged: (value) {
                                            viewModel.addressAvailable = value;
                                            },
                                            ),
                                            ],
                                            ),

                                      ),
                              Visibility(
                                  visible: viewModel.addressSwitch==isTrue,
                                  child:
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: doubleTen,),
                                         Text("address line -1".toUpperCase(), style: const TextStyle(color:  Color(
                                            0xff5ba55e)),),
                                        TextField(
                                          controller: viewModel.editAddressLine1,
                                          maxLength: 30,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            counterText: "",
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                          ),
                                        ),

                                        const SizedBox(height: doubleTen,),
                                         Text("address line -2".toUpperCase(), style: const TextStyle(color:  Color(
                                            0xff5ba55e)),),
                                        TextField(
                                          controller: viewModel.editAddressLine2,
                                          maxLength: 30,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            counterText: "",
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                          ),
                                        ),
                                        const SizedBox(height: doubleTen,),
                                         Text("address line -3".toUpperCase(), style: const TextStyle(color:  Color(
                                            0xff5ba55e)),),
                                        TextField(
                                          controller: viewModel.editAddressLine3,
                                          maxLength: 30,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            counterText: "",
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                          ),
                                        ),
                                        const SizedBox(height: doubleTen,),
                                        Text("address line -4".toUpperCase(), style: const TextStyle(color:  Color(
                                            0xff5ba55e)),),
                                        TextField(
                                          controller: viewModel.editAddressLine4,
                                          maxLength: 30,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            counterText: "",
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                          ),
                                        ),
                                        const SizedBox(height: doubleTen,),
                                        Text("pin code".toUpperCase(), style: const TextStyle(color:  Color(
                                            0xff5ba55e)),),
                                        TextField(
                                          controller: viewModel.pinCode,
                                          maxLength:6,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            counterText: "",
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                          ),
                                        ),
                                        const SizedBox(width: doubleTen,),
                                      ]
                                  ),
                              ),
                              const SizedBox(width: doubleTen,),
                              const Divider(),
                                       Text(viewModel.titleOfUpload.toUpperCase(),style: TextStyle(color:  Color(0xff5ba55e)),),
                                 Visibility(
                                   visible: viewModel.titleOfUpload!="",
                                   child:Column(
                                   children: [
                                        Row(
                                        children: [
                                          Radio<String>(
                                              value: "AADHAR",
                                              groupValue: viewModel.selectedOption,
                                              onChanged: (value){
                                                viewModel.toggleOption(value!);
                                              }
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            "AADHAR(Only for CAT-I)",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<String>(
                                              value: "MUNICIPAL",
                                              groupValue: viewModel.selectedOption,
                                              onChanged: (value){
                                                viewModel.toggleOption(value!);
                                              }
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            "MUNICIPAL TAX RECEIPT",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
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
