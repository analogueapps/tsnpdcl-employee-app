import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For Divider
import 'package:tsnpdcl_employee/view/dlist/model/range_dlist.dart';

class FindServiceSearchDialog extends StatefulWidget {
  final List<DlistEntityRealmList> items;
  const FindServiceSearchDialog({super.key, required this.items});

  @override
  State<FindServiceSearchDialog> createState() => _FindServiceSearchDialogState();
}

class _FindServiceSearchDialogState extends State<FindServiceSearchDialog> {
  late List<DlistEntityRealmList> filteredItems;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _filterItems(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      searchText = query;
      filteredItems = widget.items.where((item) {
        return item.dlscno!.toLowerCase().contains(lowerQuery) ||
            item.dlstat!.toLowerCase().contains(lowerQuery) ||
            item.dluan!.toString().toLowerCase().contains(lowerQuery) ||
            item.ctpoleno!.toLowerCase().contains(lowerQuery) ||
            item.ctname!.toLowerCase().contains(lowerQuery) ||
            item.areaname!.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Select Service'),
      message: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoSearchTextField(
            onChanged: _filterItems,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: filteredItems.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: CupertinoColors.separator),
              itemBuilder: (_, index) {
                final item = filteredItems[index];
                return CupertinoButton(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  onPressed: () => Navigator.of(context).pop(item),
                  child: Text(
                    'SC No: ${item.dlscno}(${item.dlstat})\n'
                        'USNO: ${item.dluan}(${item.ctpoleno})\n'
                        'NAME: ${item.ctname}\n'
                        'AREA: ${item.areaname}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    );
  }
}
