import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/consumer_details/viewmodel/dl_form_viewmodel.dart';

class DlistFormScreen extends StatelessWidget {
  static const id = Routes.dListFormScreen;
  final String form;
  const DlistFormScreen({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "Service Details".toUpperCase(),
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
        create: (_) => DlFormViewModel(context: context, dListForm: form),
        child: Consumer<DlFormViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(doubleTwenty),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Sc.no".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.scNoController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Usc.no".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.uscNoController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Sc.no".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.scNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Category".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.categoryController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Address".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.addressController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Amount due".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.amountDueController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Bill amount".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.billAmountController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Bill date".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.billDateController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            keyboardType: TextInputType.none,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Disc date".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.discDateController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Due date".toUpperCase(),
                            style: const TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.dueDateController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CommonColors.colorPrimary
                                  )
                              ),
                              labelStyle: TextStyle(fontFamily: appFontFamily),
                              hintStyle: TextStyle(fontFamily: appFontFamily),
                            ),
                            readOnly: isTrue,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: doubleTen,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
