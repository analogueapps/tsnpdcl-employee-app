import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/filter/viewmodel/filter_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';


class FilterScreen extends StatelessWidget {
  static const id = Routes.filterScreen;
  final String data;

  const FilterScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FilterViewModel(context: context, jsonResponse: data),
      child: Consumer<FilterViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                "Filter".toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    viewModel.clearFilters();
                  },
                  child: const Text('CLEAR FILTER',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: viewModel.filters.length,
                    itemBuilder: (context, index) {
                      final filter = viewModel.filters[index];
                      return GestureDetector(
                        onTap: () {
                          viewModel.selectFilter(filter);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(doubleFifteen),
                          color: viewModel.selectedFilter == filter
                              ? Colors.grey.shade100
                              : Colors.transparent,
                          child: Text(
                            filter.labelName!,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: viewModel.searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search here...',
                            border: const UnderlineInputBorder(),
                            suffixIcon: Visibility(
                              visible: viewModel.searchQuery.isNotEmpty,
                              child: IconButton(
                                  onPressed: () {
                                    viewModel.updateSearchQuery("");
                                    viewModel.searchController.clear();
                                  },
                                  icon: const Icon(Icons.cancel)
                              ),
                            ),
                          ),
                          onChanged: (query) {
                            viewModel.updateSearchQuery(query);
                          },
                        ),
                      ),
                      Expanded(
                        child: viewModel.filteredOptionList.isEmpty
                            ? const Center(child: Text('No filter options found'))
                            : ListView.separated(
                                itemCount: viewModel.filteredOptionList.length,
                                separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
                                itemBuilder: (context, index) {
                                  final option = viewModel.filteredOptionList[index];
                                  return CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(option.optionName!),
                                    value: option.isSelected,
                                    onChanged: (value) {
                                      viewModel.toggleOptionSelection(option);
                                    },
                                  );
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(doubleTwenty),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                        viewModel.hashMapSelectedOptions.isNotEmpty ? "(${viewModel.hashMapSelectedOptions.length}) Filters" : "(0) Filters"
                      ),
                  ),
                  Expanded(child: PrimaryButton(
                      text: "Apply Filter".toUpperCase(),
                      fullWidth: isTrue,
                      onPressed: () {
                        if(viewModel.hashMapSelectedOptions.isNotEmpty) {
                          Navigator.pop(context, viewModel.hashMapSelectedOptions);
                        } else {
                          showAlertDialog(context,"Please select at least filter criteria and try again");
                        }
                      }
                  ),)
                ],
              )
            ),
          );
        },
      ),
    );
  }
}
