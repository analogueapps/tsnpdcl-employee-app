import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/view/asset_mapping_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/corporate_login_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/employee_id_login_screen.dart';
import 'package:tsnpdcl_employee/view/consumer_details/view/consumer_details_screen.dart';
import 'package:tsnpdcl_employee/view/consumer_details/view/dlist_form_screen.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/ctpt_menu_screen.dart';
import 'package:tsnpdcl_employee/view/dashboard/view/universal_dashboard_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/view/dtr_failure_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_inspection_list_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_maintenance_inspection_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_maintenance_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_master_list_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/create_dtr_online.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/download_feeder_data.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/mis_matched_dtrs.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/view_offline_data.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/download_feeder_viewmodel.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/mapped_dtrs.dart';
import 'package:tsnpdcl_employee/view/exceptionals/view/exceptionals_screen.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/view/failure_dtr_inspection_screen.dart';
import 'package:tsnpdcl_employee/view/filter/view/filter_screen.dart';
import 'package:tsnpdcl_employee/view/ganesh_pandal/view/ganesh_pandal_info_screen.dart';
import 'package:tsnpdcl_employee/view/ganesh_pandal/view/ganesh_pandal_information_screen.dart';
import 'package:tsnpdcl_employee/view/gruha_jyothi/view/gruha_jyothi_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/breakdown_11kv_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/breakdown_33kv_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/interruptions_entry_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/saidi_saifi_calculator_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_11kv_breakdown_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_33kv_breakdown_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_saidi_saifi_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/add_induction_point_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/all_lc_request_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/feeder_induction_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/lc_master_feeder_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/line_clearance_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/lc_master_ss_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/view_detailed_lc_screen.dart';
import 'package:tsnpdcl_employee/view/manage_staff/view/manage_staffs_screen.dart';
import 'package:tsnpdcl_employee/view/measure_distance/view/measure_distance_screen.dart';
import 'package:tsnpdcl_employee/view/meeseva/view/meeseva_menu_screen.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/middle_pole_11kv.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/middle_pole_33kv.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/middle_poles_screen.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/pending_list_floating_button.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/pending_list_screen.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/view_detailed_pending_list_screen.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/view/online_pr_menu_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/create_pole_indents_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/pdms_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_di_tabs_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_pole_dumped_location_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_pole_indent_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_transport_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_dispatch_instructions_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_pole_dumped_location_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/new_proposal_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_11kv_feeder_mark_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_33kv_proposal_feeder_mark_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_proposal_11kv_feeder_mark_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_tracker_selection_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_tracker_selection_view_sketch_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/view_digital_sketch_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/view_offline_feeders_screen.dart';
import 'package:tsnpdcl_employee/view/reports/view/reports_screen.dart';
import 'package:tsnpdcl_employee/view/rfss/view/rfss_screen.dart';
import 'package:tsnpdcl_employee/view/search_consumer/view/search_consumer_screen.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/view/maintenance_due_screen.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/view/maintenance_finished_screen.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/view/ss_maintenance_screen.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/view/tong_tester_readings_screen.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/view/view_detailed_tong_tester_readings.dart';
import 'package:tsnpdcl_employee/view/web_view/view/web_view_screen.dart';
import 'package:tsnpdcl_employee/widget/pinch_zoom_imageview.dart';
import '../view/ltmt/view/ltmt_menu.dart';
import '../view/ltmt/view/meters_stock.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/create_dtr_offline.dart';
import 'package:tsnpdcl_employee/view/rfss/view/non_agl_services.dart';
import 'package:tsnpdcl_employee/view/rfss/view/agl_services.dart';
import 'package:tsnpdcl_employee/view/rfss/view/new_inspection.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case EmployeeIdLoginScreen.id:
        return MaterialPageRoute(builder: (_) => const EmployeeIdLoginScreen());
      case CorporateLoginScreen.id:
        return MaterialPageRoute(builder: (_) => const CorporateLoginScreen());
      case UniversalDashboardScreen.id:
        return MaterialPageRoute(
            builder: (_) => const UniversalDashboardScreen());
      case SearchConsumerScreen.id:
        return MaterialPageRoute(builder: (_) => const SearchConsumerScreen());
      case LineClearanceScreen.id:
        return MaterialPageRoute(builder: (_) => const LineClearanceScreen());
      case AssetMappingScreen.id:
        return MaterialPageRoute(builder: (_) => const AssetMappingScreen());
      case GaneshPandalInfoScreen.id:
        return MaterialPageRoute(
            builder: (_) => const GaneshPandalInfoScreen());
      case OnlinePrMenuScreen.id:
        return MaterialPageRoute(builder: (_) => const OnlinePrMenuScreen());
      case MeasureDistanceScreen.id:
        return MaterialPageRoute(builder: (_) => const MeasureDistanceScreen());
      case DtrMaintenanceScreen.id:
        return MaterialPageRoute(builder: (_) => const DtrMaintenanceScreen());
      case DtrFailureScreen.id:
        return MaterialPageRoute(builder: (_) => const DtrFailureScreen());
      case FailureDtrInspectionScreen.id:
        return MaterialPageRoute(
            builder: (_) => const FailureDtrInspectionScreen());
      case PdmsScreen.id:
        return MaterialPageRoute(builder: (_) => const PdmsScreen());
      case CtptMenuScreen.id:
        return MaterialPageRoute(builder: (_) => const CtptMenuScreen());
      case ConsumerDetailsScreen.id:
        return MaterialPageRoute(builder: (_) => const ConsumerDetailsScreen());
      case WebViewScreen.id:
        return MaterialPageRoute(
            builder: (_) => WebViewScreen(
                args: settings.arguments as Map<String, dynamic>));
      case MeesevaMenuScreen.id:
        return MaterialPageRoute(builder: (_) => const MeesevaMenuScreen());

      // Ganesh pandal
      case GaneshPandalInformationScreen.id:
        return MaterialPageRoute(
            builder: (_) => const GaneshPandalInformationScreen());

      // Consumer details
      case DlistFormScreen.id:
        return MaterialPageRoute(
            builder: (_) =>
                DlistFormScreen(form: settings.arguments as String));

      // Line Clearance
      case LcMasterSsListScreen.id:
        return MaterialPageRoute(builder: (_) => const LcMasterSsListScreen());
      case LcMasterFeederListScreen.id:
        return MaterialPageRoute(
            builder: (_) => LcMasterFeederListScreen(
                args: settings.arguments as Map<String, dynamic>));
      case FeederInductionListScreen.id:
        return MaterialPageRoute(
            builder: (_) => FeederInductionListScreen(
                args: settings.arguments as Map<String, dynamic>));
      case AddInductionPointScreen.id:
        return MaterialPageRoute(
            builder: (_) => AddInductionPointScreen(
                args: settings.arguments as Map<String, dynamic>));
      case AllLcRequestListScreen.id:
        return MaterialPageRoute(
            builder: (_) =>
                AllLcRequestListScreen(status: settings.arguments as String));
      case ViewDetailedLcScreen.id:
        return MaterialPageRoute(
            builder: (_) =>
                ViewDetailedLcScreen(lcId: settings.arguments as String));

      // Pole tracker
      case PoleTrackerSelectionViewSketchScreen.id:
        return MaterialPageRoute(
            builder: (_) => const PoleTrackerSelectionViewSketchScreen());
      case ViewDigitalSketchScreen.id:
        return MaterialPageRoute(
            builder: (_) => ViewDigitalSketchScreen(
                args: settings.arguments as Map<String, dynamic>));
      case NewProposalScreen.id:
        return MaterialPageRoute(
            builder: (_) =>
                NewProposalScreen(ssc: settings.arguments as String));
      case PoleTrackerSelectionScreen.id:
        return MaterialPageRoute(
            builder: (_) => const PoleTrackerSelectionScreen());
      case PoleProposal11kvFeederMarkScreen.id:
        return MaterialPageRoute(
            builder: (_) => PoleProposal11kvFeederMarkScreen(
                args: settings.arguments as Map<String, dynamic>));
      case Pole33kvProposalFeederMarkScreen.id:
        return MaterialPageRoute(
            builder: (_) => Pole33kvProposalFeederMarkScreen(
                args: settings.arguments as Map<String, dynamic>));
      case Pole11kvFeederMarkScreen.id:
        return MaterialPageRoute(
            builder: (_) => Pole11kvFeederMarkScreen(
                args: settings.arguments as Map<String, dynamic>));
      case ViewOfflineFeedersScreen.id:
        return MaterialPageRoute(
            builder: (_) => const ViewOfflineFeedersScreen());

      // BILLING RELATED
      case GruhaJyothiScreen.id:
        return MaterialPageRoute(builder: (_) => const GruhaJyothiScreen());

      // MANAGE STAFF
      case ManageStaffsScreen.id:
        return MaterialPageRoute(builder: (_) => const ManageStaffsScreen());

      // PDMS
      case CreatePoleIndentsScreen.id:
        return MaterialPageRoute(
            builder: (_) => const CreatePoleIndentsScreen());
      case ViewDetailedPoleIndentScreen.id:
        return MaterialPageRoute(
            builder: (_) => ViewDetailedPoleIndentScreen(
                data: settings.arguments as String));
      case ViewDispatchInstructionsScreen.id:
        return MaterialPageRoute(
            builder: (_) => const ViewDispatchInstructionsScreen());
      case ViewDetailedDiTabsScreen.id:
        return MaterialPageRoute(
            builder: (_) =>
                ViewDetailedDiTabsScreen(data: settings.arguments as String));
      case ViewDetailedTransportScreen.id:
        return MaterialPageRoute(
            builder: (_) => ViewDetailedTransportScreen(
                data: settings.arguments as String));
      case ViewPoleDumpedLocationScreen.id:
        return MaterialPageRoute(
            builder: (_) => ViewPoleDumpedLocationScreen(
                status: settings.arguments as String));
      case ViewDetailedPoleDumpedLocationScreen.id:
        return MaterialPageRoute(
            builder: (_) => ViewDetailedPoleDumpedLocationScreen(
                data: settings.arguments as String));

      // REPORTS
      case ReportsScreen.id:
        return MaterialPageRoute(
            builder: (_) => ReportsScreen(path: settings.arguments as String));

      // FILTER
      case FilterScreen.id:
        return MaterialPageRoute(
            builder: (_) => FilterScreen(data: settings.arguments as String));

      // EXCEPTIONALS
      case ExceptionalsScreen.id:
        return MaterialPageRoute(builder: (_) => const ExceptionalsScreen());

      // DTR MAINTENANCE
      case DtrMasterListScreen.id:
        return MaterialPageRoute(builder: (_) => const DtrMasterListScreen());
      case DtrInspectionListScreen.id:
        return MaterialPageRoute(
            builder: (_) =>
                DtrInspectionListScreen(status: settings.arguments as String));
      case DtrMaintenanceInspectionScreen.id:
        return MaterialPageRoute(
            builder: (_) => DtrMaintenanceInspectionScreen(
                data: settings.arguments as String));

      // Widgets
      case PinchZoomImageView.id:
        return MaterialPageRoute(
            builder: (_) =>
                PinchZoomImageView(imageUrl: settings.arguments as String));

      // Tong tester readings * Swetha
      case TongTesterReadingsScreen.id:
        return MaterialPageRoute(
            builder: (_) => const TongTesterReadingsScreen());
      case ViewDetailedTongTesterReadings.id:
        return MaterialPageRoute(
            builder: (_) => const ViewDetailedTongTesterReadings());

      // RFSS Screen * Swetha
      case RfssScreen.id:
        return MaterialPageRoute(builder: (_) => const RfssScreen());
      case NonAglServices.id:
        return MaterialPageRoute(builder: (_) => const NonAglServices());
      case AglServices.id:
        return MaterialPageRoute(builder: (_) => const AglServices());
      case NewInspection.id:
        return MaterialPageRoute(builder: (_) => const NewInspection());

      // Middle Poles Screen * Swetha
      case MiddlePolesScreen.id:
        return MaterialPageRoute(builder: (_) => const MiddlePolesScreen());
      case MiddlePoles33kv.id:
        return MaterialPageRoute(builder: (_) => const MiddlePoles33kv());
      case MiddlePole11kv.id:
        return MaterialPageRoute(builder: (_) => const MiddlePole11kv());
      case PendingListScreen.id:
        return MaterialPageRoute(builder: (_) => const PendingListScreen());
      case ViewDetailedPendingListScreen.id:
        return MaterialPageRoute(builder: (_) => const ViewDetailedPendingListScreen());
      case PendingListFloatingButton.id:
        return MaterialPageRoute(builder: (_) => const PendingListFloatingButton());

      // SS Maintenance Screen * Swetha
      case SsMaintenanceScreen.id:
        return MaterialPageRoute(builder: (_) => const SsMaintenanceScreen());
      case MaintenanceDueScreen.id:
        return MaterialPageRoute(builder: (_) => const MaintenanceDueScreen());
      case MaintenanceFinishedScreen.id:
        return MaterialPageRoute(builder: (_) => const MaintenanceFinishedScreen());

    // Interruptions * swetha
      case Breakdown33kvScreen.id:
        return MaterialPageRoute(builder: (_) => const Breakdown33kvScreen());
      case Breakdown11kvScreen.id:
        return MaterialPageRoute(builder: (_) => const Breakdown11kvScreen());
      case InterruptionsEntryScreen.id:
        return MaterialPageRoute(builder: (_) => const InterruptionsEntryScreen());
      case SaidiSaifiCalculatorScreen.id:
        return MaterialPageRoute(builder: (_) => const SaidiSaifiCalculatorScreen());
      case ViewSaidiSaifiScreen.id:
        return MaterialPageRoute(builder: (_) => const ViewSaidiSaifiScreen());
      case View33kvBreakdownScreen.id:
        return MaterialPageRoute(builder: (_) => const View33kvBreakdownScreen());
      case View11kvBreakdownScreen.id:
        return MaterialPageRoute(builder: (_) => const View11kvBreakdownScreen());

      //LTMT * Bhavana
      case LtmtMenu.id:
        return MaterialPageRoute(builder: (_) => const LtmtMenu());
      case MetersStock.id:
        return MaterialPageRoute(builder: (_) => const MetersStock());

      // DTR Master * Bhavana
      case MappedDtr.id:
        return MaterialPageRoute(builder: (_)=> const MappedDtr());
      case DownloadFeederData.id:
        return MaterialPageRoute(builder: (_)=> const DownloadFeederData());
      case ViewOfflineData.id:
        return MaterialPageRoute(builder: (_)=> const ViewOfflineData());
      case MisMatchedDtr.id:
        return MaterialPageRoute(builder: (_)=> const MisMatchedDtr());
      case CreateDtrOnline.id:
        return MaterialPageRoute(builder: (_)=> const CreateDtrOnline());
      case CreateDtrOffline.id:
        return MaterialPageRoute(builder: (_)=> const CreateDtrOffline());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}
