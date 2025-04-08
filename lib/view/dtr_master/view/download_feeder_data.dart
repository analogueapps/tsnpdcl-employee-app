import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/download_feeder_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class DownloadFeederData extends StatelessWidget {
  static const id= Routes.downloadFeederScreen;
  const DownloadFeederData({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DownloadFeederViewmodel(context: context),
      child: Consumer<DownloadFeederViewmodel>(
        builder: (context, viewModel, child) {
          return WillPopScope(
            // onWillPop: () async {
            //   return viewModel.isLocationGranted;
            // },
            onWillPop: null,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: CommonColors.colorPrimary,
                title: Text(
                  GlobalConstants.downloadFeeder.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: toolbarTitleSize,
                      fontWeight: FontWeight.w700),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.close_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              body:Stack(
                children: [
                  Form(
                  key: viewModel.formKey,
                  child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Sub Station", style: TextStyle(color:Colors.purple[300]),),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Select"),
                    value: viewModel.selectedSubStation,
                    items: viewModel.station.map<DropdownMenuItem<String>>((SubstationModel item) {
                      return DropdownMenuItem<String>(
                        value: item.optionCode,
                        child: Text(item.optionName),
                      );
                    }).toList(),
                    onChanged: (String? value) => viewModel.onListSubStationSelected(value),
                  ),
                  const SizedBox(height: 10,),
                  //here feeder automatically fetched from api
                  Text("Choose Feeder", style: TextStyle(color:Colors.purple[300]),),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Select"),
                    value: viewModel.chooseFeeder,
                    items: viewModel.feeder.map<DropdownMenuItem<String>>((SubstationModel item) {
                      return DropdownMenuItem<String>(
                        value: item.optionCode,
                        child: Text(item.optionName),
                      );
                    }).toList(),
                    onChanged: (String? value) => viewModel.onListFeederSelected(value),
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.grey,),
                      Text("Reserve Equipment codes for offline?", style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                        text: "SAVE FOR OFFLINE",
                        onPressed: () {
                          viewModel.submitForm();
                        }
                    ),
                  )
                ],
              )
            ),
            ),
                  if (viewModel.isLoading)
                    Positioned.fill(
                      child:  Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
              ]
            ),
          ),
          );
        },
      ),
    );
  }
}











// if (latitude == "Unknown" && longitude == "Unknown") {
// _handleLocationIconClick();
// showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// title: Text("Alert"),
// content: Text(
// "Please wait until we capture your location! Make sure your device GPS is turned ON."),
// actions: [
// TextButton(
// onPressed: () {
// Navigator.of(context).pop();
// },
// child: Text("OK"),
// ),
// ],
// );
// },
// );
// } else {
// final pickedImg = await pic.pickImage(
// source: ImageSource.camera,
// maxHeight: 1024,
// maxWidth: 1024,
// imageQuality: 80,
// );
// if (pickedImg != null) {
// setState(() {
// cameraFile = File(pickedImg.path);
// });
// }
// // Navigator.of(context).pop();
// }
