import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/asset_mapping/view/asset_mapping_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/corporate_login_screen.dart';
import 'package:tsnpdcl_employee/view/auth/view/employee_id_login_screen.dart';
import 'package:tsnpdcl_employee/view/consumer_details/view/consumer_details_screen.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/view/ctpt_menu_screen.dart';
import 'package:tsnpdcl_employee/view/dashboard/view/universal_dashboard_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/view/dtr_failure_screen.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/view/dtr_maintenance_screen.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/view/failure_dtr_inspection_screen.dart';
import 'package:tsnpdcl_employee/view/ganesh_pandal/view/ganesh_pandal_info_screen.dart';
import 'package:tsnpdcl_employee/view/ganesh_pandal/view/ganesh_pandal_information_screen.dart';
import 'package:tsnpdcl_employee/view/line_clearance/view/line_clearance_screen.dart';
import 'package:tsnpdcl_employee/view/measure_distance/view/measure_distance_screen.dart';
import 'package:tsnpdcl_employee/view/meeseva/view/meeseva_menu_screen.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/view/online_pr_menu_screen.dart';
import 'package:tsnpdcl_employee/view/pdms/view/pdms_screen.dart';
import 'package:tsnpdcl_employee/view/search_consumer/view/search_consumer_screen.dart';
import 'package:tsnpdcl_employee/view/web_view/view/web_view_screen.dart';

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
      case GaneshPandalInformationScreen.id:
        return MaterialPageRoute(
            builder: (_) => const GaneshPandalInformationScreen());
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
