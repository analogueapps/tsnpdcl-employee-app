import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/check_readings/viewmodel/check_readings_viewmodel.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';


class CheckReadings extends StatelessWidget {
  const CheckReadings({super.key});
  static const  id = Routes.checkReadingScreen;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CheckReadingViewModel(context: context),
        child: Consumer<CheckReadingViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Check Readings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor:CommonColors.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            TextButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonthYearSelector(),
                  ),
                );
                if (result != null && result is Map) {
                  viewModel.setSelectedMonthYear(
                    result['month'] as String,
                    result['year'] as int,
                    context,
                  );
                }
              },
              child: Text(
                viewModel.selectedMonthYear != null
                    ? '${viewModel.selectedMonthYear!['month']} ${viewModel.selectedMonthYear!['year']}'
                    : 'SELECT MONTH/YEAR',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        body: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            :const Center(child: Text("No Data"),),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () {
            Navigation.instance.navigateTo(Routes.enterServicesScreen);
            },
          child: const Icon(Icons.add),
        ),
      );
    }
    ),
    );
  }
}

//public void onConfirm(CheckResponseWraper checkResponseWraper) {
//    ///     linkAadhar(checkResponseWraper.getCircle(),checkResponseWraper.getErono(),checkResponseWraper.getScno());
//  if (getIntent().getBooleanExtra("bs_udc",false))
// {
// Intent webIntent = new Intent(context, WebActivity.class);
// webIntent.putExtra("url", ApiServices.PAGE_ROOT_URL + "bsUdcEntryForm.jsp?scno=" + checkResponseWraper.getUscno() + "&ero=" + LoginSdk.getInsatnce().getNpdclUser(context).getSecMasterEntity().getEroId() + "&emp_id=" + LoginSdk.getInsatnce().getNpdclUser(context).getEmpId() + "&sectionId=" + LoginSdk.getInsatnce().getNpdclUser(context).getSecMasterEntity().getSectionId());
// webIntent.putExtra("t", "BS/UDC Inspection");
// startActivity(webIntent);
// }else {
// Intent webIntent = new Intent(context, WebActivity.class);
// webIntent.putExtra("url", ApiServices.PAGE_ROOT_URL + "checkReadingEntryForm.jsp?scno=" + checkResponseWraper.getUscno() + "&ero=" + LoginSdk.getInsatnce().getNpdclUser(context).getSecMasterEntity().getEroId() + "&emp_id=" + LoginSdk.getInsatnce().getNpdclUser(context).getEmpId() + "&sectionId=" + LoginSdk.getInsatnce().getNpdclUser(context).getSecMasterEntity().getSectionId());
//  webIntent.putExtra("t", "Check Reading");
//   startActivity(webIntent);
//    }
//  }


//class : ServiceAndUscNo
// Request Body: {"token":"26973097C0CE4D15A995879E87A81729","cid":"1","app":"in.tsnpdcl.npdclemployee"}