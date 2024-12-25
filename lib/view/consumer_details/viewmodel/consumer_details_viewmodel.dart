import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class ConsumerDetailsViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  bool _isLTServiceSelected = isFalse;
  bool _isHTServiceSelected = isFalse;

  bool get isLTServiceSelected => _isLTServiceSelected;
  bool get isHTServiceSelected => _isHTServiceSelected;

  // Form Keys
  final formKey = GlobalKey<FormState>();
  final TextEditingController uscNoController = TextEditingController();

  ConsumerDetailsViewmodel({required this.context});

  void selectLTService() {
    _isLTServiceSelected = isTrue;
    _isHTServiceSelected = isFalse;
    notifyListeners();
  }

  void selectHTService() {
    _isHTServiceSelected = isTrue;
    _isLTServiceSelected = isFalse;
    notifyListeners();
  }

  void fetchDetails() {
    if(_isLTServiceSelected || _isHTServiceSelected) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        notifyListeners();
      }
    } else {
      AlertUtils.showSnackBar(context, "Please check the type of service", isTrue);
    }
  }
}
