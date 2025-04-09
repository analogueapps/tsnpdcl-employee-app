import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';

class StructureDtrList extends StatelessWidget {
  static const id = Routes.structureDtrList;
  final Map<String, dynamic> structure;

  const StructureDtrList({required this.structure});

  @override
  Widget build(BuildContext context) {
    final dtrs = structure['dtrs'] as List<dynamic>? ?? [];
    return ListView.builder(
      itemCount: dtrs.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return StructureDetailsCard(structure: structure);
        } else {
          return TongTesterReadingCard(dtr: dtrs[index - 1]);
        }
      },
    );
  }
}

class StructureDetailsCard extends StatelessWidget {
  final Map<String, dynamic> structure;

  const StructureDetailsCard({required this.structure});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Structure Code: ${structure['structureCode'] ?? ''}"),
            Text("Landmark: ${structure['landMark'] ?? ''}"),
            Text("Distribution: ${structure['distributionName'] ?? ''}"),
            Text("SS No: ${structure['ssNo'] ?? ''}"),
            Text("SS Code: ${structure['ssCode'] ?? ''}"),
            Text("Feeder Code: ${structure['feederCode'] ?? ''}"),
            Text("Capacity: ${structure['capacity'] ?? ''}"),
            Text("Structure Type: ${structure['structureType'] ?? ''}"),
            Text("Plinth Type: ${structure['plinthType'] ?? ''}"),
            Text("AB Switch: ${structure['abSwitch'] ?? ''}"),
            Text("HG Fuse Set: ${structure['hgFuseSet'] ?? ''}"),
            Text("LT Fuse Set: ${structure['ltFuseSet'] ?? ''}"),
            Text("LT Fuse Type: ${structure['ltFuseType'] ?? ''}"),
            Text("Load Pattern: ${structure['loadPattern'] ?? ''}"),
            Text("Latitude: ${structure['lat'] ?? ''}"),
            Text("Longitude: ${structure['lon'] ?? ''}"),
            Text("Created Date: ${structure['createdDate'] ?? ''}"),
            Text("Created By: ${structure['createdBy'] ?? ''}"),
          ],
        ),
      ),
    );
  }
}

class TongTesterReadingCard extends StatefulWidget {
  final Map<String, dynamic> dtr;

  const TongTesterReadingCard({required this.dtr});

  @override
  _TongTesterReadingCardState createState() => _TongTesterReadingCardState();
}

class _TongTesterReadingCardState extends State<TongTesterReadingCard> {
  final TextEditingController _irPhController = TextEditingController();
  final TextEditingController _iyPhController = TextEditingController();
  final TextEditingController _ibPhController = TextEditingController();
  final TextEditingController _inPhController = TextEditingController();
  final TextEditingController _loadInKvaController = TextEditingController();
  String? _locationType;
  DateTime? _readingDate;
  TimeOfDay? _readingTime;

  final List<String> _locationTypes = [
    "--- SELECT ---",
    "MUNICIPAL TOWN",
    "MANDAL HEAD QUARTERS",
    "RURAL"
  ];

  @override
  void initState() {
    super.initState();
    _irPhController.text = widget.dtr['irPh'] ?? '';
    _iyPhController.text = widget.dtr['iYPh'] ?? '';
    _ibPhController.text = widget.dtr['ibPh'] ?? '';
    _inPhController.text = widget.dtr['inPh'] ?? '';
    _loadInKvaController.text = widget.dtr['loadInKva'] ?? '';
    _locationType = widget.dtr['locationType'] ?? _locationTypes[0];
    _readingDate = widget.dtr['readingDate'] != null ? DateFormat('dd/MM/yyyy').parse(widget.dtr['readingDate']) : null;
    _readingTime = widget.dtr['readingTime'] != null ? TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(widget.dtr['readingTime'])) : null;

    _irPhController.addListener(() => widget.dtr['irPh'] = _irPhController.text);
    _iyPhController.addListener(() => widget.dtr['iYPh'] = _iyPhController.text);
    _ibPhController.addListener(() => widget.dtr['ibPh'] = _ibPhController.text);
    _inPhController.addListener(() => widget.dtr['inPh'] = _inPhController.text);
    _loadInKvaController.addListener(() => widget.dtr['loadInKva'] = _loadInKvaController.text);
  }

  @override
  void dispose() {
    _irPhController.dispose();
    _iyPhController.dispose();
    _ibPhController.dispose();
    _inPhController.dispose();
    _loadInKvaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("EQ CODE: ${widget.dtr['equipmentCode'] ?? ''}"),
            Text("CAP: ${widget.dtr['dtrCapacity'] ?? ''}"),
            Text("MAKE: ${widget.dtr['make'] ?? ''} SERIAL: ${widget.dtr['slno'] ?? ''}"),
            CachedNetworkImage(
              imageUrl: widget.dtr['url'] ?? '',
              placeholder: (context, url) => Icon(Icons.image),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 100,
              width: 100,
            ),
            TextField(controller: _irPhController, decoration: InputDecoration(labelText: "R-Ph Current")),
            TextField(controller: _iyPhController, decoration: InputDecoration(labelText: "Y-Ph Current")),
            TextField(controller: _ibPhController, decoration: InputDecoration(labelText: "B-Ph Current")),
            TextField(controller: _inPhController, decoration: InputDecoration(labelText: "Neutral Current")),
            TextField(controller: _loadInKvaController, decoration: InputDecoration(labelText: "Load in KVA")),
            DropdownButtonFormField<String>(
              value: _locationType,
              items: _locationTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (value) {
                setState(() {
                  _locationType = value;
                  widget.dtr['locationType'] = value == "--- SELECT ---" ? "0" : value;
                });
              },
              decoration: InputDecoration(labelText: "Location Type"),
            ),
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _readingDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _readingDate = pickedDate;
                    widget.dtr['readingDate'] = DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
              child: Text(_readingDate != null ? DateFormat('dd/MM/yyyy').format(_readingDate!) : "Select Date"),
            ),
            ElevatedButton(
              onPressed: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _readingTime ?? TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _readingTime = pickedTime;
                    widget.dtr['readingTime'] = pickedTime.format(context);
                  });
                }
              },
              child: Text(_readingTime != null ? _readingTime!.format(context) : "Select Time"),
            ),
          ],
        ),
      ),
    );
  }
}