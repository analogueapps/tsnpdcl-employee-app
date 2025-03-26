import 'package:flutter/cupertino.dart';

import '../../../utils/app_constants.dart';

class MeterstockViewmodel extends ChangeNotifier{
  MeterstockViewmodel({required this.context});

  // Current View Context
  final BuildContext context;

  bool _checkBox = isFalse; // Controls Check Box
  bool get isBoxChecked => _checkBox;


}