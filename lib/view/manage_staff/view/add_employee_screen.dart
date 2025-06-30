import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/manage_staff/viewmodel/add_employee_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class AddEmployeeScreen extends StatelessWidget {
  static const id = Routes.addEmployeeScreen;

  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD STAFF',
          style: TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: CommonColors.colorPrimary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AddEmployeeViewModel(context),
        child: Consumer<AddEmployeeViewModel>(
            builder: (context, viewModel, child) {
          return viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'O&M STAFF EMPLOYEE ID',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: viewModel.empIdController,
                            keyboardType: TextInputType.number,
                            readOnly: viewModel.edit,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Employee Id"),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          const Text(
                            'MOBILE NUMBER',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: viewModel.empMobileNoController,
                            keyboardType: TextInputType.number,
                            readOnly: viewModel.edit,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Mobile No"),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          !viewModel.edit
                              ? PrimaryButton(
                                  text: "GET DETAILS",
                                  fullWidth: isTrue,
                                  onPressed: () {
                                    if (viewModel.isValidate(context)) {
                                      viewModel.getUserDetails(context);
                                    }
                                  },
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 21,
                                    ),
                                    // Text(viewModel.objectList[0]['employeeId'],style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(
                                      viewModel.empId ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    Text(viewModel.name ?? ""),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    Text(viewModel.mobileNo ?? ""),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    const Text(
                                      'CHOOSE STAFF TYPE ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: viewModel.fieldStaff,
                                            onChanged: (value) {
                                              viewModel.setFieldStaff(value!);
                                            }),
                                        const Text('FIELD STAFF'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: viewModel.subStationOperator,
                                            onChanged: (value) {
                                              viewModel.setSsOperator(value!);
                                            }),
                                        const Text('SUBSTATION OPERATOR'),
                                      ],
                                    ),
                                    const Text(
                                      'ASSIGN SUBSTATION',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: DropdownButtonFormField<String>(
                                        value: viewModel.selectedLocation,
                                        decoration: const InputDecoration(
                                          labelText: 'SUBSTATION',
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 14),
                                        ),
                                        hint: const Text("Select Location"),
                                        isExpanded: true,
                                        items:
                                            viewModel.locations.map((location) {
                                          return DropdownMenuItem(
                                            value: location,
                                            child: Text(location),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          viewModel.setLocation(value!);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.red,
                                            ),
                                            onPressed: () {},
                                            child: const Text('CANCLE')),
                                        const SizedBox(
                                          width: 11,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3))),
                                            onPressed: () {
                                              if (viewModel
                                                  .validateConfirm(context)) {
                                                viewModel
                                                    .confirmAddStaff(context);
                                              }
                                            },
                                            child: const Text('CONFIRM')),
                                      ],
                                    )
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
