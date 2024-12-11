
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';

class Assets {
  static const String appLogo = 'assets/images/npdcl_logo.svg';

  static const String updateApp = 'assets/images/app.png';
  static const String searchConsumer = 'assets/images/graph.png';
  static const String lineClearance = 'assets/images/man_on_work_removebg_preview.png';
  static const String assetMapping = 'assets/images/map.png';
  static const String ganeshPandalInfo = 'assets/images/ganesha.png';
  static const String onlinePr = 'assets/images/counter.png';
  static const String measureDist = 'assets/images/measure_tape.png';
  static const String consumerDetails = 'assets/images/search.png';
  static const String gruhaJyothi = 'assets/images/home.png';
  static const String dtrMaintenance = 'assets/images/mechanic.png';
  static const String dtrFailure = 'assets/images/dtr_inspection.png';
  static const String failureDtrInspection = 'assets/images/inspection.png';
  static const String ssMaintenance = 'assets/images/tool_bag.png';
  static const String pmiOfLines = 'assets/images/trimming.png';
  static const String rfss = 'assets/images/strength.png';
  static const String schedules = 'assets/images/timetable.png';
  static const String mappingOfNonAglServices = 'assets/images/map_location.png';
  static const String tongTesterReadings = 'assets/images/clamp.png';
  static const String uscNo = 'assets/images/conversion.png';
  static const String gisIds = 'assets/images/route.png';
  static const String uploadCasteCertificate = 'assets/images/file.png';
  static const String meeseva = 'assets/images/power_supply.png';
  static const String exceptionals = 'assets/images/meter.png';
  static const String ltmt = 'assets/images/delegation.png';
  static const String electroMech = 'assets/images/meter.png';
  static const String poloTracker = 'assets/images/electric_pole.png';
  static const String dtrMaster = 'assets/images/power_transformer.png';
  static const String dList = 'assets/images/tool.png';
  static const String dListReport = 'assets/images/result.png';
  static const String middlePoles = 'assets/images/electric_pole__1_.png';
  static const String maintenance = 'assets/images/tool_bag.png';
  static const String checkReadings = 'assets/images/meter.png';
  static const String bsUdcInspection = 'assets/images/disconnected.png';
  static const String interruptions = 'assets/images/broken_wire.png';
  static const String manageStaff = 'assets/images/team.png';
  static const String newServices = 'assets/images/planning.png';
  static const String ctPtFailure = 'assets/images/transformer.png';
  static const String pdms = 'assets/images/truck.png';
  static const String reports = 'assets/images/monitor.png';
  static const String checkMeasurement = 'assets/images/compare.png';
  static const String focc = 'assets/images/call_center_agent.png';
  static const String ebs = 'assets/images/desktop.png';
  static const String mats = 'assets/images/fraud_alert.png';
  static const String account = 'assets/images/profile.png';
  static const String logout = 'assets/images/logout.png';


  static OutlineInputBorder squareInputBorder(){ //return type is OutlineInputBorder
    return const OutlineInputBorder( //Outline border type for TextFiled
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: CommonColors.textFieldColor,
          width: 1.5,
        )
    );
  }

  static OutlineInputBorder squareFocusBorder(){
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: CommonColors.textFieldColor,
          width: 1.5,
        )
    );
  }
}
