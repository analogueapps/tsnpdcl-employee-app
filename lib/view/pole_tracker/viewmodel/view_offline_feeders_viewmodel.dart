
import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/database/save_offline_feeder.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/offline_feeder.dart';

class ViewOfflineFeedersViewmodel extends ChangeNotifier {
  ViewOfflineFeedersViewmodel({required this.context});

  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  List<OffLineFeeder> trackerOfflineFeeder=[];

Future<List<OffLineFeeder>> fetchFeeders() async {
  trackerOfflineFeeder= await OFDatabaseHelper.instance.getAllOfflineFeeders();
  return await OFDatabaseHelper.instance.getAllOfflineFeeders();
}


}

