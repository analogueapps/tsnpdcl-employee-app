import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/view/asset_mapping_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/corporate_login_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/employee_id_login_screen.dart';
import 'package:tsnpdcl_employee/view/consumer_details/view/consumer_details_screen.dart';
import 'package:tsnpdcl_employee/view/consumer_details/view/dlist_form_screen.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/ctpt_menu_screen.dart';
import 'package:tsnpdcl_employee/view/dashboard/view/universal_dashboard_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/view/dtr_failure_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_maintenance_screen.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/view/failure_dtr_inspection_screen.dart';
import 'package:tsnpdcl_employee/view/ganesh_pandal/view/ganesh_pandal_info_screen.dart';
import 'package:tsnpdcl_employee/view/ganesh_pandal/view/ganesh_pandal_information_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/add_induction_point_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/all_lc_request_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/feeder_induction_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/lc_master_feeder_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/line_clearance_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/lc_master_ss_list_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/view_detailed_lc_screen.dart';
import 'package:tsnpdcl_employee/view/measure_distance/view/measure_distance_screen.dart';
import 'package:tsnpdcl_employee/view/meeseva/view/meeseva_menu_screen.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/view/online_pr_menu_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/pdms_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/new_proposal_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/pole_tracker_selection_view_sketch_screen.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/view/view_digital_sketch_screen.dart';
import 'package:tsnpdcl_employee/view/search_consumer/view/search_consumer_screen.dart';
import 'package:tsnpdcl_employee/view/web_view/view/web_view_screen.dart';
import 'package:tsnpdcl_employee/widget/pinch_zoom_imageview.dart';

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
            builder: (_) => DlistFormScreen(
                form: settings.arguments as String));

      // Line Clearance
      case LcMasterSsListScreen.id:
        return MaterialPageRoute(
            builder: (_) => const LcMasterSsListScreen());
      case LcMasterFeederListScreen.id:
        return MaterialPageRoute(
            builder: (_) => LcMasterFeederListScreen(args: settings.arguments as Map<String, dynamic>));
      case FeederInductionListScreen.id:
        return MaterialPageRoute(
            builder: (_) => FeederInductionListScreen(args: settings.arguments as Map<String, dynamic>));
      case AddInductionPointScreen.id:
        return MaterialPageRoute(
            builder: (_) => AddInductionPointScreen(args: settings.arguments as Map<String, dynamic>));
      case AllLcRequestListScreen.id:
        return MaterialPageRoute(
            builder: (_) => AllLcRequestListScreen(status: settings.arguments as String));
      case ViewDetailedLcScreen.id:
        return MaterialPageRoute(
            builder: (_) => ViewDetailedLcScreen(lcId: settings.arguments as String));


      // Pole tracker
      case PoleTrackerSelectionViewSketchScreen.id:
        return MaterialPageRoute(
            builder: (_) => const PoleTrackerSelectionViewSketchScreen());
      case ViewDigitalSketchScreen.id:
        return MaterialPageRoute(
            builder: (_) => ViewDigitalSketchScreen(args: settings.arguments as Map<String, dynamic>));
      case NewProposalScreen.id:
        return MaterialPageRoute(
            builder: (_) => NewProposalScreen(ssc: settings.arguments as String));



      // Widgets
      case PinchZoomImageView.id:
        return MaterialPageRoute(
            builder: (_) => PinchZoomImageView(imageUrl: settings.arguments as String));


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
