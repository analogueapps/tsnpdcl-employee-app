import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/global_list_dialog_item.dart';

class CustomListDialog extends StatelessWidget {
  final List<GlobalListDialogItem> items;
  final String title;
  final double? width;
  final double? height;
  final Function(GlobalListDialogItem)? onItemSelected;

  const CustomListDialog({
    super.key,
    required this.items,
    required this.title,
    this.width,
    this.height,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 300, // You can adjust this for more/less visible items
            child: CupertinoScrollbar(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      onItemSelected?.call(items[index]);
                    },
                    child: Text(items[index].title),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
