import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/application_status.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/meeseva/viewmodel/services_app_list_viewmodel.dart';

class ServicesAppListScreen extends StatelessWidget {
  static const id = Routes.servicesAppListScreen;
  final Map<String, dynamic> data;
  const ServicesAppListScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ServicesAppListViewmodel(context: context, data: data),
      child: Consumer<ServicesAppListViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                ApplicationStatus.getApplicationStatusName(data['s']).toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: toolbarTitleSize,
                    fontWeight: FontWeight.w700),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    viewModel.loadApplications();
                  },
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.filterApplicationsList.isEmpty
                ? const Center(child: Text("No data founded."),)
                : ListView.builder(
                itemCount: viewModel.filterApplicationsList.length,
                itemBuilder: (context, index) {
                  final item = viewModel.filterApplicationsList[index];

                  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.registrationDateAsLong);
                  final String formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(dateTime);

                  return GestureDetector(
                    onTap: () {
                      var argument = {
                        "regNum": item.registrationNumber,
                        "regId": item.regId,
                        "status": item.status,
                      };
                      if (data['sc'] != null) {
                        argument['sc'] = data['sc'];
                      }
                      Navigation.instance.navigateTo(Routes.formLoaderScreen, args: argument);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(doubleFive),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: doubleSixty,
                                height: doubleSixty,
                                margin: const EdgeInsets.only(right: doubleFive),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: pointFive),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: item.photoUrl ?? "N/A",
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter:
                                          const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                    ),
                                  ),
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Image.asset(
                                    Assets.account,
                                    filterQuality: FilterQuality.low,
                                  ),
                                ),
                              ),
                              // Name and Application No
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            checkNull(item.consumerName),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const Icon(Icons.keyboard_arrow_right),
                                      ],
                                    ),
                                    Text(
                                      checkNull(item.registrationNumber),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: doubleFive),
                          Row(
                            children: [
                              Text(
                                formattedDate,
                                style: const TextStyle(fontSize: extraRegularSize, fontWeight: FontWeight.w500,),
                              ),
                              const SizedBox(width: doubleFive),
                              Expanded(
                                child: Text(
                                  checkNull(item.village),
                                  style: const TextStyle(fontSize: extraRegularSize, fontWeight: FontWeight.w500,),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: doubleFive),
                          Container(
                            height: doubleOne,
                            width: double.infinity,
                            color: const Color(0xFFEEEEEE),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
