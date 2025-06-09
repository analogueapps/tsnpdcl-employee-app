import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/database/save_offline_feeder.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/digital_feeder_entity.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/offline_feeder.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/new_sketch_prop_entity.dart';
import 'package:tsnpdcl_employee/view/rfss/database/mapping_agl_db/agl_databases/structure_code_db.dart';
import 'package:tsnpdcl_employee/view/rfss/model/dtrStructureEntity.dart';

class PoleTrackerSelectionViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  String? selectedCheckboxId;
  bool isSelected(String id) => selectedCheckboxId == id;

  String? selectedPurposeCheckboxId;
  bool isPurposeSelected(String id) => selectedPurposeCheckboxId == id;

  String? selectedProposalCheckboxId;
  bool isProposalSelected(String id) => selectedProposalCheckboxId == id;

  List<SpinnerList> listSubStationItem = [];
  String? listSubStationSelect;
  String? listSubStationSelectBottom;

  List<SpinnerList> listFeederItem = [];
  String? listFeederSelect;
  String? listFeederSelectBottom;

  NewSketchPropEntity? newSketchPropEntity;

  // Entry field
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController estimateController = TextEditingController();

  // duplicate predict
  bool duplicate = isTrue;

  // Constructor to initialize the items
  PoleTrackerSelectionViewModel({required this.context});

  void duplicateCheck(bool? value) {
    duplicate = value!;
    notifyListeners();
  }

  void selectCheckbox(String id) {
    listSubStationItem.clear();
    listSubStationSelect = null;
    listSubStationSelectBottom = null;
    listFeederItem.clear();
    listFeederSelect = null;
    listFeederSelectBottom = null;
    selectedPurposeCheckboxId = null;
    selectedProposalCheckboxId = null;
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    notifyListeners();
    if (selectedCheckboxId == id) {
      selectedCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      selectedCheckboxId = id;
      if(id == "33KV Line"){
        get132KVSSLines();
      } else if(id == "11 KV Line") {
        get33kVSsOfCircle();
      }
    }
    notifyListeners(); // Notify the view about the change
  }

  void selectPurposeCheckbox(String id) {
    if (listSubStationSelect == null) {
      showAlertDialog(context, "Please select the Substation first.!");
      return;
    }
    // listFeederItem.clear();
    // listFeederSelect = null;
    // listFeederSelectBottom = null;
    selectedProposalCheckboxId = null;
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    if (selectedPurposeCheckboxId == id) {
      selectedPurposeCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      selectedPurposeCheckboxId = id;
      if (id == "NFP") {
        listFeederItem.clear(); // ✅ Clear before adding
        listFeederItem.add(
          SpinnerList(optionCode: "NFP", optionName: "New Feeder Proposal"),
        );
        listFeederSelect = "NFP";
        listFeederSelectBottom = listFeederSelect;
      }
      else {
        get33KVFeederOf132KVSSLines(listSubStationSelect!);
      }
    }
    notifyListeners(); // Notify the view about the change
  }

  void selectProposalCheckbox(String id) {
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    if (selectedProposalCheckboxId == id) {
      selectedProposalCheckboxId = null; // Uncheck if the same checkbox is clicked
    } else {
      if(id == "EP") {
        Navigation.instance.navigateTo(Routes.newProposalScreen, args: listSubStationSelect,onReturn: (result) {
          if(result != null) {
            Map<String, dynamic> jsonMap = json.decode(result);
            newSketchPropEntity = NewSketchPropEntity.fromJson(jsonMap);
            descriptionController.text = newSketchPropEntity!.proposalDesc ?? "";
            estimateController.text = newSketchPropEntity!.estimateNo ?? "";
            selectedProposalCheckboxId = id;
            notifyListeners();
          }
        });
      } else {
        selectedProposalCheckboxId = id;
      }
    }
    notifyListeners(); // Notify the view about the change
  }

  Future<void> get132KVSSLines() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/load/132kvss",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                listSubStationItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void onListSubStationItemSelect(String? value) {
    listSubStationSelect = value;
    listSubStationSelectBottom = listSubStationSelect;
    listFeederItem.clear();
    listFeederSelect = null;
    listFeederSelectBottom = null;
    selectedPurposeCheckboxId = null;
    selectedProposalCheckboxId = null;
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    print("listSubStationSelect: $listSubStationSelect");
    getFeeders(listSubStationSelect!);
    notifyListeners();
  }

  Future<void> get33KVFeederOf132KVSSLines(String ss) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ss": ss,
    };

    final payload = {
      "path": "/load/load33kvfdrOf132KvSs",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                listFeederItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void onListFeederItemSelect(String? value) {
    listFeederSelect = value;
    listFeederSelectBottom = listFeederSelect;
    selectedProposalCheckboxId = null;
    newSketchPropEntity = null;
    descriptionController.clear();
    estimateController.clear();
    notifyListeners();
    getStructFeederDis(listFeederSelect!);
  }

  Future<void> get33kVSsOfCircle() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/load/load33kvssOfCircle",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                listSubStationItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> getFeeders(String ss) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ss": ss,
    };

    final payload = {
      "path": "/load/feeders",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<SpinnerList> listData = jsonList.map((json) => SpinnerList.fromJson(json)).toList();
                listFeederItem.add(SpinnerList(optionCode: "NFP", optionName: "New Feeder Proposal"));
                listFeederItem.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> digitizeNow() async {
    if(!onDigitizeClicked()){
      return;
    }else{
      if(selectedProposalCheckboxId == "CNP") {
        createNewProposal();
      } else if(selectedProposalCheckboxId == "EP") {

        if(descriptionController.text.isNotEmpty&& descriptionController.text!=null||descriptionController.text==""){
          var argument = {
            'd': json.encode(newSketchPropEntity!),
            'p': true,
            'ssc': listSubStationSelect,
            'ssn': listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName,
            'fc': listFeederSelect,
            'fn': listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName,
          };
          selectedCheckboxId=="11 KV Line"?
          Navigation.instance.navigateTo(Routes.pole11kvScreen, args: argument)
              : Navigation.instance.navigateTo(Routes.pole33kvScreen, args: argument);

        }else{
          //newProposalScreen
          Navigation.instance.navigateTo(Routes.newProposalScreen, args: listSubStationSelect);
        }

      } else if(selectedPurposeCheckboxId == "DEF") {
        var argument = {
          'p': false,
          'ssc': listSubStationSelect,
          'ssn': listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName,
          'fc': listFeederSelect,
          'fn': listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName,
        };
        if(selectedCheckboxId=="33KV Line"){
          Navigation.instance.navigateTo(Routes.pole33kvProposalFeederMarkScreen, args: argument);
        }else{
          var argument = {
            'p': false,
            'ssc': listSubStationSelect,
            'ssn': listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName,
            'fc': listFeederSelect,
            'fn': listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName,
          };
          Navigation.instance.navigateTo(Routes.pole11kvFeederMarkScreen, args: argument);
        }
      }
    }
  }

  Future<void> saveForOffline() async {
    if (!onDigitizeClicked()) {
      print("save on onDigitizeClicked");
      return;
    }else{
      getPolesOnFeeder();
      print("on getPolesOnFeeder");
    }
  }

  bool onDigitizeClicked()  {
    if(selectedCheckboxId != null) {
      if (listSubStationSelect == null)  {
        showAlertDialog(context, "Please select the Substation");
        return false;
      } else if (selectedPurposeCheckboxId == null)  {
        showAlertDialog(context, "Please select the purpose");
        return false;
      } else if (listFeederSelect == null)  {
        showAlertDialog(context, "Please select the Feeder");
        return false;
      } else if (selectedPurposeCheckboxId!="DEF"&&selectedProposalCheckboxId == null)  {
        showAlertDialog(context, "Please select the Proposal Option");
        return false;
      } else if (selectedProposalCheckboxId == "CNP" && descriptionController.text.length < 10)  {
        showAlertDialog(context, "Please enter the description of work for the New Proposal.");
        return false;
      }

    } else {
      showAlertDialog(context, "Please select the Line Voltage level");
      return false;
    }
    return true;
  }




  Future<void> createNewProposal() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Creating Proposal...",
    );

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "v": selectedCheckboxId,
      "ssn": listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName,
      "ssc":  listSubStationSelect,
      "fc": listFeederSelect,
      "fn": listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName,
      "pt": selectedProposalCheckboxId == "NFP" ? "NFP" : "LEP",
      "pdc": descriptionController.text.trim(),
      "estno": estimateController.text.trim(),
    };

    final payload = {
      "path": "/createNewProposal",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<NewSketchPropEntity> listData = jsonList.map((json) => NewSketchPropEntity.fromJson(json)).toList();
                if (listData.isNotEmpty) {
                  var argument = {
                    'd': json.encode(listData[0]),
                    'p': true,
                    'ssc': listSubStationSelect,
                    'ssn': listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName,
                    'fc': listFeederSelect,
                    'fn': listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName,
                  };
                  // Navigation.instance.navigateTo(Routes.poleProposal11kvFeederMarkScreen, args: argument);
                  selectedCheckboxId=="11 KV Line"?
                  Navigation.instance.navigateTo(Routes.pole11kvScreen, args: argument)
                      : Navigation.instance.navigateTo(Routes.pole33kvScreen, args: argument);
                } else {
                  showErrorDialog(context, "Unable to process your request!");
                }
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> getPolesOnFeeder() async {
    notifyListeners();

    _isLoading = isTrue;

    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssc":listSubStationSelect,
      "fc": listFeederSelect,
    };

    final payload = {
      "path": "/getPolesOnFeeder",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            List<dynamic> responseList = jsonDecode(response.data['objectJson']);

            List<DigitalFeederEntity> poleList = responseList.map((item) => DigitalFeederEntity.fromJson(item)).toList();

            final databaseOffLineFeeder = OffLineFeeder(
              ssCode: listSubStationSelect??"",
              ssName: listSubStationItem.firstWhere((item) => item.optionCode == listSubStationSelect).optionName??"",
              feederCode: listFeederSelect??"",
              feederName: listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName??"",
              insertDate: DateTime.now().millisecondsSinceEpoch,
              voltageLevel: selectedCheckboxId=="11 KV Line" ? "11KV" : "33KV",
              digitalFeederEntityList:poleList,
            );
            await DatabaseHelper.instance.insertOfflineFeeder(databaseOffLineFeeder, poleList);

            // *** WARNING ***
            // I/flutter (22899):
            // I/flutter (22899): Invalid argument [{id: 625712, newProposalId: null, sourceId: 625162, sourceLat: 18.3318643, sourceLon: 78.4001671, sourceType: POLE, isProposalExecuted: y, poleType: PSSC Pole, poleHeight: 8.0 Mtr. Pole, noOfCkts: 1 Circuit, formation: Triangular, typeOfPoint: Pin Point, crossing: None, loadType: null, haveLoad: N, condSize: 55 sq.mm, lat: 18.3326197, lon: 78.400194, purpose: DIGI, voltage: 11KV, ssCode: 0848-33KV SS-AREPALLY, feederCode: 0848-02-11KV AREPALLYAGL, ssVolt: 33/11KV, feederVolt: 11KV, insertDate: Jul 8, 2020 12:00:00 AM, createdBy: 40001406, poleNum: ARE003, tempSeries: null, tapping: s, distanceFeeder: .084264925163863672592452071353429884305, circleCode: null, fName: null, sName: null, extensionPole: N}, {id: 625720, newProposalId: null, sourceId: 625712, sourceLat: 18.3326197, sourceLon: 78.400194, sourceType: POLE, isProposalExecuted: y, poleType: PSSC Pole, poleHeight: 8.0 Mtr. Pole, noOfCkts: 1 Circuit, formation: Triangular, typeOfPoint: Pin Point, crossing: None, loadT
            // I/flutter (22899): #0      _checkArg (package:sqflite_common/src/value_utils.dart:30:7)
            // I/flutter (22899): #1      checkNonNullValue (package:sqflite_common/src/value_utils.dart:51:5)
            // I/flutter (22899): #2      new SqlBuilder.insert.<anonymous closure> (package:sqflite_common/src/sql_builder.dart:180:11)
            // I/flutter (22899): #3      _LinkedHashMapMixin.forEach (dart:_compact_hash:763:13)
            // I/flutter (22899): #4      new SqlBuilder.insert (package:sqflite_common/src/sql_builder.dart:169:14)
            // I/flutter (22899): #5      SqfliteDatabaseExecutorMixin.insert (package:sqflite_common/src/database_mixin.dart:61:32)
            // I/flutter (22899): #6      DatabaseHelper.insertOfflineFeeder (package:tsnpdcl_employee/view/pole_tracker/database/save_offline_feeder.dart:53:14)
            // I/flutter (22899): <asynchronous suspension>
            // I/flutter (22899): #7      PoleTrackerSelectionViewModel.getPolesOnFeeder (package:tsnpdcl_employee/view/pole_tracker/viewmodel/pole_tracker_selection_viewmodel.dart:590:13)
            // I/flutter (22899): <asynchronous suspension>
            // E/flutter (22899): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: DatabaseException(java.util.HashMap cannot be cast to java.lang.Integer) sql 'INSERT OR REPLACE INTO offline_feeder (feederCode, feederName, ssCode, ssName, voltageLevel, insertDate, digitalFeederEntityList) VALUES (?, ?, ?, ?, ?, ?, ?)' args [0848-02-11KV AREPALLYAGL, AREPALLY AGL, 0848-33KV SS-AREPALLY, AREPALLY, 11KV, 1749461642799, [{sourceId: 625162, sourceLat: 18.3318643, poleHei...]

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Success'),
                content: Text(
                    '${listFeederItem.firstWhere((item) => item.optionCode == listFeederSelect).optionName} saved for offline digitization, existing poles on feeder ${poleList.length}'),
                actions: [
                  TextButton(
                      onPressed: () { Navigator.of(context).pop();
                      print("Pole tracker poleList : $poleList");},
                      child: const Text('OK')),

                ],
              ),
            );

          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "$e");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> getStructFeederDis(String feederValue) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading...",
    );

    final requestFData = {
      "authToken": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey) ?? "",
      "api": Apis.API_KEY,
      "fc": feederValue,
      "status": "",
      "ignoreSection": true
    };


    final payload = {
      "path": "/getStructuresOfFeederOrDistribution",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestFData),
    };

    final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              final decoded = jsonDecode(response.data['message']);
              if (decoded is List && decoded.isNotEmpty){
                final List<dynamic> structures =decoded;
                final dbHelper = StructureDatabaseHelper.instance;
                print("Structure insertions starting...");

                for (var json in structures) {
                  final structure = DTRStructureEntity.fromJson(json);
                  await dbHelper.insertStructure(structure);
                }
                print("Structure insertions done.");
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      print("Stacktrace: $e");
      rethrow;
    }
    notifyListeners();
  }


}


