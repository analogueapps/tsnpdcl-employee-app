import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/consumer_details/viewmodel/consumer_details_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class ConsumerDetailsScreen extends StatelessWidget {
  static const id = Routes.consumerDetailsScreen;
  const ConsumerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: const Text(
         "Enter Service No",
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
        create: (_) => ConsumerDetailsViewmodel(context: context),
        child: Consumer<ConsumerDetailsViewmodel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(doubleSixteen),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Service Type',
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: doubleTen),
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: viewModel.isLTServiceSelected,
                              onChanged: (value) {
                                viewModel.selectLTService();
                              },
                            ),
                            const Text('LT Service'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: viewModel.isHTServiceSelected,
                              onChanged: (value) {
                                viewModel.selectHTService();
                              },
                            ),
                            const Text('HT Service'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: doubleTen),
                    const Divider(
                      height: doubleOne,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: doubleTwenty),
                    FillTextFormField(
                      controller: viewModel.uscNoController,
                      labelText: 'Enter USCNO',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter service no";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: doubleForty),
                    Center(
                      child: PrimaryButton(
                          fullWidth: isTrue,
                          text: 'FETCH DETAILS',
                          onPressed: () {
                            viewModel.fetchDetails();
                          }
                      ),
                    )
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
