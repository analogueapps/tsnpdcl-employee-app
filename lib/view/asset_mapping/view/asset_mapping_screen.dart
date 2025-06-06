import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/viewmodel/asset_mapping_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class AssetMappingScreen extends StatefulWidget {
  static const id = Routes.assetMappingScreen;

  const AssetMappingScreen({super.key});

  @override
  State<AssetMappingScreen> createState() => _AssetMappingScreenState();
}

class _AssetMappingScreenState extends State<AssetMappingScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          GlobalConstants.assetMappingTitle.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AssetMappingViewModel(),
        child: Consumer<AssetMappingViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Choose Asset Type', style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w500)),
                  const SizedBox(height: doubleFifteen),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: CommonColors.colorPrimary
                          )
                      ),
                    ),
                    items: viewModel.assetTypeList.map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        viewModel.assetSelection(newValue);
                      }
                    },
                    value: viewModel.assetSelectValue,
                    hint: const Text('Choose Asset Type'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    isExpanded: isTrue,
                    iconEnabledColor: CommonColors.colorPrimary,
                  ),
                  const SizedBox(height: doubleFifteen),
                  Divider(
                    height: doubleOne,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: doubleFifteen),
                  const Text('Asset Code', style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w500)),
                  const SizedBox(height: doubleFifteen),
                  FillTextFormField(
                    controller: viewModel.assetCodeController,
                    labelText: "",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: doubleFifteen),
                  Divider(
                    height: doubleOne,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: doubleFifteen),
                  if (viewModel.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Latitude: ${viewModel.latitude ?? "Fetching..."}',
                            style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.w500)),
                        const SizedBox(height: doubleTen),
                        Text(
                            'Longitude: ${viewModel.longitude ?? "Fetching..."}',
                            style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.w500)),
                        const SizedBox(height: doubleTen),
                        Text(
                          'Location Accuracy: ${viewModel.totalAccuracy}',
                          style:  TextStyle(fontSize: titleSize, fontWeight: FontWeight.w500, color: viewModel.totalAccuracy!<=viewModel.MINIMUM_GPS_ACCURACY_REQUIRED ?  Colors.green : Colors.red),
                        ),
                        const SizedBox(height: doubleFifteen),
                        Divider(
                          height: doubleOne,
                          color: Colors.grey[200],
                        ),
                      ],
                    ),
                  const Spacer(),
                  Center(
                    child: PrimaryButton(
                        text: "Save",
                        fullWidth: isTrue,
                        onPressed: () {
                          if(viewModel.validate(context)){
                            viewModel.postAssetInfo(context);
                          }
                        }
                    ),
                  ),
                  const SizedBox(height: doubleTen),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
