import 'package:flutter/cupertino.dart';

class InterruptionsControllers {
  final TextEditingController elInterruption;
  final TextEditingController olInterruption;
  final TextEditingController lcInterruption;
  final TextEditingController bdInterruption;
  final TextEditingController elOlInterruption;

  InterruptionsControllers()
      : elInterruption = TextEditingController(),
        olInterruption = TextEditingController(),
        bdInterruption = TextEditingController(),
        lcInterruption = TextEditingController(),
        elOlInterruption = TextEditingController();
}

class DurationControllers {
  final TextEditingController elDuration;
  final TextEditingController olDuration;
  final TextEditingController lcDuration;
  final TextEditingController bdDuration;
  final TextEditingController elOlDuration;

  DurationControllers()
      : elDuration = TextEditingController(),
        olDuration = TextEditingController(),
        bdDuration = TextEditingController(),
        lcDuration = TextEditingController(),
        elOlDuration = TextEditingController();
}