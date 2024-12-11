import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/universal_dashboard_item.dart';

class DrawerSection {
  final String title;
  final IconData leadingIcon;
  final List<UniversalDashboardItem> items;

  DrawerSection({
    required this.title,
    required this.leadingIcon,
    required this.items,
  });
}
