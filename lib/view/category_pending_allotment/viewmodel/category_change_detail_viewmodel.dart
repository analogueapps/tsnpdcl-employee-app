import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/view/category_pending_allotment/model/category_change_request_model.dart';

class CategoryChangeDetailViewmodel extends ChangeNotifier {
   CategoryChangeDetailViewmodel({required this.data, required this.context});

  final BuildContext context;
  final CategoryChangeRequestModel data;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;
}
