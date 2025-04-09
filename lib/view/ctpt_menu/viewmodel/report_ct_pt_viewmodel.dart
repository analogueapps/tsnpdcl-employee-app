import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';

class CTFailureReportViewModel extends ChangeNotifier {
  final BuildContext context;
  bool isLoading = false;

  String? selectedHTSC;
  String? selectedVillage;
  String? selectedMake;
  String? selectedCTPTRatio = '200/1-1';

  final TextEditingController mfController = TextEditingController();
  final TextEditingController serialNoController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController makeController = TextEditingController();

  final List<String> htscList = [
    'WLU347(M/S ANAGANDULA SANTHOSH)',
    'WLU335(M/S A MUKUNDA REDDY)',
    'R WLU311(M/S GUJJA PRABHAKAR RAO & OTHERS)',
    'WLU294(M/S CHAKILAM KRISHNA CHAITANYA & AVI..',
    'WLU254(M/S KALANIKETAN SILKS PVT.LTD.)',
    'WLU277(M/S NIMMA DIVIJENDER REDDY)',
    'WLU161(M/S. MUKKA DILIP KUMAR &)',
    'WLU138(M/S.GATEWAY 2 ORUGALLU,)',
    'WLU219(M/S A.P.TOURISM DEVELOPMENT)',
    'WLU194(THE CHIEF GENERAL MANAGER/OP/)',
    'WLU102(M/S.SUPRABHA HOTEL)',
    'WLU100(M/S.SANJEEVANI HEALTHCARE P.L.)',
    'WLU261(M/S SRI NIMMA DIVIJENDER REDDY)',
    'WLU081(M/S ORUGALLU MEDICARE(P) LTD)',
    'WLU080(STATE COMMERCIAL MANAGER,)',
    'WLU047(THE SUB DIVISIONAL ENGINEER,)',
    'WLU396(M/S CHANDUPATLA SUDHEER CHANDER RE..',
    'WLU046(SENIOR DIVISIONAL MANAGER)',
    'WLU190(M/S IDEAL DEVELOPERS)',
  ];

  final List<String> villageList = [
    'RTC COLONY', 'NAKKALAGUTTA', 'BALASAMUDRAM','BHAVANINAGART','RAMNAGAR','NGOs COLONY','POLICE HEAD QUARTERS',
    'SAINAGAR','BHEESHMANAGAR','GOKULNAGAR','ASHOKE COLONY','ADVOCATES COLONY','H B COLONY','KISHANPURA1','GANDHINAGAR'
  ];

  final List<String> makeList = [
    'L&T', 'VIDYUTH CONTROL', 'MEHURU','VEMET ELECT','AVON','INDICON','CONCORED','INDIAN TRANFORMERS',
    'MERTO','PLASTERFAB','UNIVERSAL','VIJAY ELECTRICALS','ETC','S&S','JYOTHI','VICTORY','ACROTRANS CONTROL','ISL INDUSTRIES','SB INSTRUMENTS',
    'BHEL','TOSHIBA','HINDUSTHAN','CROMPTION GREAVES','VIDYUTH','VISHAL','VIJAY','GYRO','AMEI','PERFECT SALES','GSE','RAVINDRA ELECTRIC',
    'SGE','LAXMI ENGINEERING','STEMEC','STRATON','LAMCO','HPE','MODERN ELECTRONIC','CGPI','JVS SWITCH GEARS LLP','WS INDUSTRIES','GE T&D'
  ];

  final List<String> ctptRatioList = [
    '200/1-1', '100/1-1', '50/1-1','600/5-5','400/5-5','200/5-5','100/5-5','50/5-5','600/1-1-0.557',
    '400/1-1-0.557','200/1-1-0.557','100/1-1-0.557','500/1-1-0.557','150/1-1','150/5-5','300/1-1','300/1-1-0.577','500/1-1','2000/1-1',
    '75/1-1','600/1-1','400/1-1','1200/1-1','800/1-1','1600/1-1','3000/1-1',''
  ];

  CTFailureReportViewModel({required this.context});

  String extractMiddlePartRevised(String text) {
    int startIndex = text.indexOf('(');
    int endIndex = text.lastIndexOf(')');

    if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
      return text.substring(startIndex + 1, endIndex);
    }
    return '';
  }

  void updateHTSC(String? value) {
    selectedHTSC = value;
    notifyListeners();
  }

  void updateVillage(String? value) {
    selectedVillage = value;
    notifyListeners();
  }

  void updateMake(String? value) {
    selectedMake = value;
    makeController.text = value ?? '';
    notifyListeners();
  }

  void updateCTPTRatio(String? value) {
    selectedCTPTRatio = value;
    notifyListeners();
  }

  void submitForm() {
    // Add your submission logic here
    // You can access all form data through the controllers and selected values
  }
}