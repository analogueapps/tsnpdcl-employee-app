import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/account_screen/view/account_screen.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/view/asset_mapping_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/change_password_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/corporate_login_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/employee_id_login_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/otp_verification_screen.dart';
import 'package:tsnpdcl_employee/view/bs_udc_inspection/view/bs_udc_list.dart';
import 'package:tsnpdcl_employee/view/ccc/model/open_model.dart';
import 'package:tsnpdcl_employee/view/ccc/view/ccc_dashboard.dart';
import 'package:tsnpdcl_employee/view/ccc/view/ccc_oricb.dart';
import 'package:tsnpdcl_employee/view/ccc/view/open_detail_screen.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/view/check_measure_11kv.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/view/check_measure_33KV.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/view/check_measure_screen.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/view/docket.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/view/pole_11KV_feeder.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/view/pole_33KV_feeder.dart';
import 'package:tsnpdcl_employee/view/check_readings/view/check_readings_screen.dart';
import 'package:tsnpdcl_employee/view/check_readings/view/enter_service_details.dart';
import 'package:tsnpdcl_employee/view/consumer_details/view/consumer_details_screen.dart';
import 'package:tsnpdcl_employee/view/consumer_details/view/dlist_form_screen.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/model/failure_report.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/ctpt_menu_screen.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/view_detailed_ctpt_report.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/view_failure_confirmed_list.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/view_issued_list.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/view_replaced_list.dart';
import 'package:tsnpdcl_employee/view/dashboard/view/adeop_navi_screen.dart';
import 'package:tsnpdcl_employee/view/dashboard/view/navi_dashboard_screen.dart';
import 'package:tsnpdcl_employee/view/dashboard/view/universal_dashboard_screen.dart';
import 'package:tsnpdcl_employee/view/dlist/view/cluster_map_screen.dart';
import 'package:tsnpdcl_employee/view/dlist/view/dlist_attend_screen.dart';
import 'package:tsnpdcl_employee/view/dlist/view/dlist_filter_screen.dart';
import 'package:tsnpdcl_employee/view/dlist/view/dlist_menu_screen.dart';
import 'package:tsnpdcl_employee/view/dlist/view/range_wise_dlist_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/view/dtr_failure_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/view/dtr_view_rectified_reports.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_inspection_list_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_maintenance_inspection_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_maintenance_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_master_list_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/create_dtr_online.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/download_feeder_data.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/mis_matched_dtrs.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/view_mapped/mapped_dtr.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/view_mapped/struct_details.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/view_offline_data.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/view_mapped/configure_filter.dart';
import 'package:tsnpdcl_employee/view/exceptionals/view/exceptionals_screen.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/view/dtr_inspection.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/view/failure_dtr_inspection_screen.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/view/view_closed_reports.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/view/view_inspection_reports.dart';
import 'package:tsnpdcl_employee/view/filter/view/filter_screen.dart';
import 'package:tsnpdcl_employee/view/ganesh_pandal/view/ganesh_pandal_info_screen.dart';
import 'package:tsnpdcl_employee/view/ganesh_pandal/view/ganesh_pandal_information_screen.dart';
import 'package:tsnpdcl_employee/view/gis_ids/view/offline_forms/gis_offline_list.dart';
import 'package:tsnpdcl_employee/view/gis_ids/view/offline_forms/pending_offline_list.dart';

import 'package:tsnpdcl_employee/view/gruha_jyothi/view/gruha_jyothi_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/breakdown_11kv_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/breakdown_33kv_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/detailed_view_11kv_breakdown_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/detailed_view_33kv_breakdown_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/interruptions_entry_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/saidi_saifi_calculator_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_11kv_breakdown_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_11kv_open_restore_details.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_33kv_breakdown_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_33kv_open_restore_details.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_report_screen.dart';
import 'package:tsnpdcl_employee/view/interruptions/view/view_saidi_saifi_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/add_induction_point_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/all_lc_request_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/feeder_induction_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/lc_master_feeder_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/line_clearance_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/lc_master_ss_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/view_detailed_lc_screen.dart';
import 'package:tsnpdcl_employee/view/ltmt/view/ltmt_menu.dart';
import 'package:tsnpdcl_employee/view/ltmt/view/meters_stock.dart';
import 'package:tsnpdcl_employee/view/manage_staff/view/manage_staffs_screen.dart';
import 'package:tsnpdcl_employee/view/measure_distance/view/measure_distance_screen.dart';
import 'package:tsnpdcl_employee/view/meeseva/view/form_loader_screen.dart';
import 'package:tsnpdcl_employee/view/meeseva/view/mee_seva_abstract_screen.dart';
import 'package:tsnpdcl_employee/view/meeseva/view/meeseva_menu_screen.dart';
import 'package:tsnpdcl_employee/view/meeseva/view/section_screen.dart';
import 'package:tsnpdcl_employee/view/meeseva/view/services_app_list_screen.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/middle_pole_11kv.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/middle_pole_33kv.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/middle_poles_screen.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/pending_list_floating_button.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/pending_list_screen.dart';
import 'package:tsnpdcl_employee/view/middle_poles/view/view_detailed_pending_list_screen.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/view/issue_duplicate_receipt.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/view/online_collection.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/view/online_pr_menu_screen.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/view/print_last_pr.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/view/rerports.dart';
import 'package:tsnpdcl_employee/view/pdms/view/create_firm_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/create_pole_indents_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/pdms_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_di_tabs_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_inspection_ticket_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_pole_dumped_location_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_pole_indent_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_detailed_transport_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_dispatch_instructions_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_firms_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_inspection_tickets_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/view_pole_dumped_location_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/new_proposal_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_11kv_feeder_mark_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_33kv_proposal_feeder_mark_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_proposal_11kv_feeder_mark_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_tracker_selection_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_tracker_selection_view_sketch_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/view_digital_sketch_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/view_offline_feeders_screen.dart';
import 'package:tsnpdcl_employee/view/ptr_feeder_loaders/view/ptr_freeder_screen.dart';
import 'package:tsnpdcl_employee/view/reports/view/reports_screen.dart';
import 'package:tsnpdcl_employee/view/rfss/view/download_structures_screen.dart';
import 'package:tsnpdcl_employee/view/rfss/view/rfss_screen.dart';
import 'package:tsnpdcl_employee/view/schedules/models/view_schedule_model.dart';
import 'package:tsnpdcl_employee/view/schedules/view/33kv_screen.dart';
import 'package:tsnpdcl_employee/view/schedules/view/schedule.dart';
import 'package:tsnpdcl_employee/view/schedules/view/ss_inspection.dart';
import 'package:tsnpdcl_employee/view/schedules/view/view_detail_schedules.dart';
import 'package:tsnpdcl_employee/view/schedules/view/view_schedule.dart';
import 'package:tsnpdcl_employee/view/search_consumer/view/search_consumer_screen.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/view/maintenance_due_screen.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/view/maintenance_finished_screen.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/view/ss_maintenance_screen.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/overload_dtr_list_model.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/view/overloaded_floating_button_screen.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/view/overLoad_dtr_list.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/view/view_detailed_tong_tester_readings.dart';
import 'package:tsnpdcl_employee/view/verify_wrong_category/view/areaWiseAbstract.dart';
import 'package:tsnpdcl_employee/view/verify_wrong_category/view/inspect_services.dart';
import 'package:tsnpdcl_employee/view/web_view/view/web_view_screen.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';
import 'package:tsnpdcl_employee/widget/pinch_zoom_imageview.dart';
import 'package:tsnpdcl_employee/view/dtr_master/view/create_dtr_offline.dart';
import 'package:tsnpdcl_employee/view/rfss/view/non_agl_services.dart';
import 'package:tsnpdcl_employee/view/rfss/view/agl_services.dart';
import 'package:tsnpdcl_employee/view/rfss/view/new_inspection.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/view/dtr_view_failure_reports.dart';
import 'package:tsnpdcl_employee/view/ltmt/view/meters_OM.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/report_ct_pt_failure.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/view_ct_pt_report_list.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/view/dtr_failure_reporting.dart';
import 'package:tsnpdcl_employee/view/gis_ids/view/add_gis_point.dart';
import 'package:tsnpdcl_employee/view/gis_ids/view/create_gis_id.dart';
import 'package:tsnpdcl_employee/view/gis_ids/view/gis_ids.dart';
import 'package:tsnpdcl_employee/view/gis_ids/view/gis_individual.dart';
import 'package:tsnpdcl_employee/view/gis_ids/view/view_work_details.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';
import 'package:tsnpdcl_employee/view/gis_ids/view/view_work_floating_button.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case EmployeeIdLoginScreen.id:
        return MaterialPageRoute(builder: (_) => const EmployeeIdLoginScreen());
      case CorporateLoginScreen.id:
        return MaterialPageRoute(builder: (_) => const CorporateLoginScreen());
      case ChangePasswordScreen.id:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen(empId: settings.arguments as String));
      case OtpVerificationScreen.id:
        return MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(data: settings.arguments as Map<String, dynamic>));

      case UniversalDashboardScreen.id:
        return MaterialPageRoute(
            builder: (_) => const UniversalDashboardScreen());
      case NaviDashboardScreen.id:
        return MaterialPageRoute(
            builder: (_) => const NaviDashboardScreen());
      case AdeopNaviScreen.id:
        return MaterialPageRoute(
            builder: (_) => const AdeopNaviScreen());

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
      case ViewDetailedCtptReport.id: // * swetha
        return MaterialPageRoute(
          builder: (_) => ViewDetailedCtptReport(
            data: settings.arguments
            as FailureReportModel, // Cast to FailureReportModel
          ),
        );
      case ConsumerDetailsScreen.id:
        return MaterialPageRoute(builder: (_) => const ConsumerDetailsScreen());
      case WebViewScreen.id:
        return MaterialPageRoute(
            builder: (_) => WebViewScreen(
                args: settings.arguments as Map<String, dynamic>));
      case MeesevaMenuScreen.id:
        return MaterialPageRoute(builder: (_) => const MeesevaMenuScreen());
      case SectionScreen.id:
        return MaterialPageRoute(builder: (_) => const SectionScreen());

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
      case ViewFirmsScreen.id:
        return MaterialPageRoute(
            builder: (_) => const ViewFirmsScreen());
      case CreateFirmScreen.id:
        return MaterialPageRoute(
            builder: (_) => CreateFirmScreen(data: settings.arguments as String));
      case ViewInspectionTicketsScreen.id:
        return MaterialPageRoute(
            builder: (_) => const ViewInspectionTicketsScreen());
      case ViewDetailedInspectionTicketScreen.id:
        return MaterialPageRoute(
            builder: (_) => ViewDetailedInspectionTicketScreen(data: settings.arguments as String));

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

    // Tong tester readings * Bhavana
      case OverLoadDTRList.id:
        return MaterialPageRoute(builder: (_) => const OverLoadDTRList());
      case OverloadedFloatingButtonView.id:
        return MaterialPageRoute(builder: (_) => const OverloadedFloatingButtonView());
      case ViewDetailedTongTesterReadings.id:
        final args = settings.arguments as OverloadDtrListModel;
        return MaterialPageRoute(builder: (_) =>  ViewDetailedTongTesterReadings(data: args
        ));


    // RFSS Screen * Bhavana
      case RfssScreen.id:
        return MaterialPageRoute(builder: (_) => const RfssScreen());
    //Bhavana
      case NonAglServices.id:
        return MaterialPageRoute(builder: (_) => const NonAglServices());
      case AglServices.id:
        return MaterialPageRoute(builder: (_) => const AglServices());
      case NewInspection.id:
        return MaterialPageRoute(builder: (_) => const NewInspection());
      case DownloadStructuresScreen.id:
        return MaterialPageRoute(builder: (_) => const DownloadStructuresScreen());



    // Middle Poles Screen * Swetha API * BHAVANA
      case MiddlePolesScreen.id:
        return MaterialPageRoute(builder: (_) => const MiddlePolesScreen());
      case MiddlePoles33kv.id:
        return MaterialPageRoute(builder: (_) => const MiddlePoles33kv());
      case MiddlePole11kv.id:
        return MaterialPageRoute(builder: (_) => const MiddlePole11kv());
      case PendingListScreen.id:
        return MaterialPageRoute(builder: (_) =>  PendingListScreen(status: settings.arguments as String,));
      case ViewDetailedPendingListScreen.id:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>  ViewDetailedPendingListScreen(
              surveyID: args['surveyID'] ?? '',
              status: args['status'] ?? '',
            )
        );
      case PendingListFloatingButton.id:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>  PendingListFloatingButton(
              surveyID: args['surveyID'] ?? '',
              status: args['status'] ?? '',));

    // SS Maintenance Screen * Swetha API*BHavana
      case SsMaintenanceScreen.id:
        return MaterialPageRoute(builder: (_) => const SsMaintenanceScreen());
      case MaintenanceDueScreen.id:
        return MaterialPageRoute(builder: (_) => const MaintenanceDueScreen());
      case MaintenanceFinishedScreen.id:
        return MaterialPageRoute(
            builder: (_) => const MaintenanceFinishedScreen());

    // Interruptions * swetha
      case Breakdown33kvScreen.id:
        return MaterialPageRoute(builder: (_) => const Breakdown33kvScreen());
      case Breakdown11kvScreen.id:
        return MaterialPageRoute(builder: (_) => const Breakdown11kvScreen());
      case InterruptionsEntryScreen.id:
        return MaterialPageRoute(
            builder: (_) => const InterruptionsEntryScreen());
      case SaidiSaifiCalculatorScreen.id:
        return MaterialPageRoute(
            builder: (_) => const SaidiSaifiCalculatorScreen());
      case ViewSaidiSaifiScreen.id:
        return MaterialPageRoute(builder: (_) => const ViewSaidiSaifiScreen());
      case View33kvBreakdownScreen.id:
        return MaterialPageRoute(
            builder: (_) => const View33kvBreakdownScreen());
      case View11kvBreakdownScreen.id:
        return MaterialPageRoute(
            builder: (_) => const View11kvBreakdownScreen());
      case DetailedView33kvBreakdownScreen.id:
        return MaterialPageRoute(
            builder: (_) => DetailedView33kvBreakdownScreen(
              data: settings.arguments as Map<String, dynamic>,
            ));
      case DetailedView11kvBreakdownScreen.id:
        return MaterialPageRoute(
            builder: (_) => DetailedView11kvBreakdownScreen(
              data: settings.arguments as Map<String, dynamic>,
            ));
      case View33kvOpenRestoreDetails.id:
        return MaterialPageRoute(
            builder: (_) => View33kvOpenRestoreDetails(
              data: settings.arguments as Map<String, dynamic>,
            ));
      case View11kvOpenRestoreDetails.id:
        return MaterialPageRoute(
            builder: (_) => View11kvOpenRestoreDetails(
              data: settings.arguments as Map<String, dynamic>,
            ));
      case MonthYearSelector.id:
        return MaterialPageRoute(
            builder: (_) =>
            const MonthYearSelector()); //data: settings.arguments as Map<String, dynamic>,
      case ViewReportScreen.id:
        return MaterialPageRoute(
            builder: (_) =>
            const ViewReportScreen()); //data: settings.arguments as Map<String, dynamic>,

    //LTMT * Bhavana
      case LtmtMenu.id:
        return MaterialPageRoute(builder: (_) => const LtmtMenu());
      case MetersStock.id:
        return MaterialPageRoute(builder: (_) => const MetersStock());
      case MetersOm.id:
        return MaterialPageRoute(
            builder: (_) => MetersOm(empId: settings.arguments as String));

    // DTR Master * Bhavana
      case ConfigureFilter.id:
        return MaterialPageRoute(builder: (_) => const ConfigureFilter());
      case MappedDtr.id:
        return MaterialPageRoute(
            builder: (_) => MappedDtr(
                structureData: settings.arguments as List<FeederDisModel>));
      case DownloadFeederData.id:
        return MaterialPageRoute(builder: (_) => const DownloadFeederData());
      case ViewOfflineData.id:
        return MaterialPageRoute(builder: (_) => const ViewOfflineData());
      case MisMatchedDtr.id:
        return MaterialPageRoute(builder: (_) => const MisMatchedDtr());
      case CreateDtrOnline.id:
        return MaterialPageRoute(builder: (_) => const CreateDtrOnline());
      case CreateDtrOffline.id:
        return MaterialPageRoute(builder: (_) => const CreateDtrOffline());
      case StructDetails.id:
        return MaterialPageRoute(
            builder: (_) => StructDetails(
                structData: settings.arguments as List<FeederDisModel>));

    // DTR FAILURE* bhavana
      case DtrFailureReporting.id:
        return MaterialPageRoute(builder: (_) => const DtrFailureReporting());
      case ReportDTRFailure.id:
        return MaterialPageRoute(builder: (_) => const ReportDTRFailure());
      case DtrFailureRectifiedReports.id:
        return MaterialPageRoute(builder: (_) => const DtrFailureRectifiedReports());

    //FAILURE DTR(S) INSPECTION * BHAVANA
      case ReportedDTRFailure.id:
        return MaterialPageRoute(builder: (_) => const ReportedDTRFailure());
      case ViewClosedReports.id:
        return MaterialPageRoute(builder: (_) => const ViewClosedReports());
      case ViewInspectionReports.id:
        return MaterialPageRoute(builder: (_) => const ViewInspectionReports());



    //CT PT FAILURE API * Bhavana
      case CTFailureReportScreen.id:
        return MaterialPageRoute(builder: (_) => const CTFailureReportScreen());
      case FailureReportedList.id:
        return MaterialPageRoute(builder: (_) => const FailureReportedList());
      case ViewFailureConfirmedList.id:
        return MaterialPageRoute(builder: (_) => const ViewFailureConfirmedList());
      case ViewReplacedList.id:
        return MaterialPageRoute(builder: (_) => const ViewReplacedList());
      case ViewIssuedList.id:
        return MaterialPageRoute(builder: (_) => const ViewIssuedList());



    //GIS DIS *bhavana
      case GISIDsScreen.id:
        return MaterialPageRoute(builder: (_) => const GISIDsScreen());
      case CreateGisId.id:
        return MaterialPageRoute(builder: (_) => const CreateGisId());
      case AddGisPoint.id:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => AddGisPoint(gis: args['gis'],gisId:args['gisId'] ,gisReg:args['gisReg'] ,t:args['t'] ,));
      case ViewWorkFloatingButton.id:
        return MaterialPageRoute(builder: (_)=> ViewWorkFloatingButton(surId: settings.arguments as String));
      case GisIndividualId.id:
        return MaterialPageRoute(
            builder: (_) => GisIndividualId(
              individualGIDId: settings.arguments as int,
            ));
      case PendingOfflineList.id:
        return MaterialPageRoute(builder: (_)=> const PendingOfflineList());
      case GisOfflineList.id:
        return MaterialPageRoute(builder: (_)=> const GisOfflineList());
      case WorkDetailsPage.id:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => WorkDetailsPage(
            surveyID: args['surveyID'] ?? '',
            status: args['status'] ?? '',
          ),
        );

    // ACCOUNT * SWETHA
      case AccountScreen.id:
        return MaterialPageRoute(builder: (_) => const AccountScreen());

    //CHECK READINGS * BHAVANA
      case CheckReadings.id:
        return MaterialPageRoute(builder: (_) => const CheckReadings());
      case EnterServiceDetails.id:
        return MaterialPageRoute(builder: (_) => EnterServiceDetails(bs_udc:settings.arguments as bool ,));

    //BS_UDC * BHAVANA
      case BsUdcList.id:
        return MaterialPageRoute(builder: (_) => const BsUdcList());

    //ONLINE PR * BHAVANA(SAI)
      case IssueDuplicateReceipt.id:
        return MaterialPageRoute(builder: (_) => const IssueDuplicateReceipt());
      case PrintLastPrView.id:
        return MaterialPageRoute(builder: (_) => const PrintLastPrView());
      case ReportsView.id:
        return MaterialPageRoute(builder: (_) => const ReportsView());
      case OnlineCollectionView.id:
        return MaterialPageRoute(builder: (_) => const OnlineCollectionView());

    // MEESEVA * Surya
      case MeeSevaAbstractScreen.id:
        return MaterialPageRoute(builder: (_)=> MeeSevaAbstractScreen(data: settings.arguments as Map<String, dynamic>));
      case ServicesAppListScreen.id:
        return MaterialPageRoute(builder: (_)=> ServicesAppListScreen(data: settings.arguments as Map<String, dynamic>,));
      case FormLoaderScreen.id:
        return MaterialPageRoute(builder: (_)=> FormLoaderScreen(data: settings.arguments as Map<String, dynamic>,));

    // DLIST * Surya
      case DlistMenuScreen.id:
        return MaterialPageRoute(builder: (_) => const DlistMenuScreen());
      case RangeWiseDlistScreen.id:
        return MaterialPageRoute(builder: (_)=> RangeWiseDlistScreen(data: settings.arguments as String,));
      case ClusterMapScreen.id:
        return MaterialPageRoute(builder: (_)=> ClusterMapScreen(data: settings.arguments as Map<String, dynamic>,));
      case DlistAttendScreen.id:
        return MaterialPageRoute(builder: (_)=> DlistAttendScreen(data: settings.arguments as String,));
      case DlistFilterScreen.id:
        return MaterialPageRoute(
            builder: (_) => DlistFilterScreen(data: settings.arguments as Map<String, dynamic>));

    //CCC Dashboard * Bhavana
      case CCCDashboardScreen.id:
        return MaterialPageRoute(builder: (_) => const CCCDashboardScreen());
      case CccOricb.id:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) =>  CccOricb(
          status: args['status'] ?? '',
          title: args['name'] ?? '',
        ));

      case CCCViewDetailed.id:
        final args = settings.arguments as CccOpenModel;
        return MaterialPageRoute(builder: (_) =>  CCCViewDetailed(data: args
        ));

    //Schedules * Bhavana
      case SchedulesScreen.id:
        return MaterialPageRoute(builder: (_) => const SchedulesScreen());
      case ViewSchedule.id:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => ViewSchedule(
          dt: args['dt'] ?? '',
          type: args['type'] ?? '',
        ));
      case ViewDetailSchedules.id:
        final args = settings.arguments as ViewScheduleModel;
        return MaterialPageRoute(builder: (_) =>  ViewDetailSchedules(data: args
        ));
      case Kv33Screen.id:
        return MaterialPageRoute(builder: (_) =>  Kv33Screen(args: settings.arguments as Map<String, dynamic>));
      case SsInspection.id:
        return MaterialPageRoute(builder: (_) =>  SsInspection(args: settings.arguments as Map<String, dynamic>));

    // VERIFY WRONG CONFIRMATIONS * Bhavana
      case AreaWiseAbstractView.id:
        return MaterialPageRoute(builder: (_) => const AreaWiseAbstractView());
      case InspectServices.id:
        return MaterialPageRoute(builder: (_) => InspectServices(args: settings.arguments as Map<String, dynamic>));

      //PTR & FEEDER LOADERS * Bhavana
      case PtrFeederScreen.id:
        return MaterialPageRoute(builder: (_) => const PtrFeederScreen());

        //CHECK MEASUREMENT(LINES)*BHAVANA
        case CheckMeasureScreen.id:
        return MaterialPageRoute(builder: (_) => const CheckMeasureScreen());
        case DocketScreen.id:
        return MaterialPageRoute(builder: (_) =>  DocketScreen(ssc: settings.arguments as String));
        case Pole11kvFeeder.id:
        return MaterialPageRoute(builder: (_) =>  Pole11kvFeeder(args: settings.arguments as Map<String, dynamic>));
        case Pole33kvFeeder.id:
        return MaterialPageRoute(builder: (_) =>  Pole33kvFeeder(args: settings.arguments as Map<String, dynamic>));
        case CheckMeasure11kv.id:
        return MaterialPageRoute(builder: (_) =>  CheckMeasure11kv(args: settings.arguments as Map<String, dynamic>));
        case CheckMeasure33kv.id:
        return MaterialPageRoute(builder: (_) =>  CheckMeasure33kv(args: settings.arguments as Map<String, dynamic>));

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