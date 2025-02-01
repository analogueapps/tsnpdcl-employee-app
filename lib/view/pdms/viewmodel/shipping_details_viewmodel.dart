import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_dispatch_instructions_entity.dart';

class ShippingDetailsViewModel extends ChangeNotifier {
  final BuildContext context;
  final PoleDispatchInstructionsEntity poleDispatchInstructionsEntity;

  ShippingDetailsViewModel({required this.context, required this.poleDispatchInstructionsEntity});
}
