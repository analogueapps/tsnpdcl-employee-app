import 'dart:convert';

BarGraphData barGraphDataFromJson(String str) =>
    BarGraphData.fromJson(json.decode(str));

String barGraphDataToJson(BarGraphData data) => json.encode(data.toJson());

class BarGraphData {
  BarGraphData({
    this.explorePath,
    this.title,
    this.ofccode,
    this.xAxisValues,
    this.typeOfGraph,
    this.subOfficeCodes,
    this.lineGraphData,
    this.barEntryDataList,
  });

  BarGraphData.fromJson(dynamic json) {
    explorePath = json['explorePath'];
    title = json['title'];
    ofccode = json['Ofccode'];
    xAxisValues =
        json['xAxisValues'] != null ? json['xAxisValues'].cast<String>() : [];
    typeOfGraph = json['typeOfGraph'];
    if (json['subOfficeCodes'] != null) {
      subOfficeCodes = [];
      json['subOfficeCodes'].forEach((v) {
        subOfficeCodes?.add(SubOfficeCodes.fromJson(v));
      });
    }
    lineGraphData = json['lineGraphData'] != null
        ? LineGraphData.fromJson(json['lineGraphData'])
        : null;
    if (json['barEntryDataList'] != null) {
      barEntryDataList = [];
      json['barEntryDataList'].forEach((v) {
        barEntryDataList?.add(BarEntryDataList.fromJson(v));
      });
    }
  }

  String? explorePath;
  String? title;
  String? ofccode;
  List<String>? xAxisValues;
  String? typeOfGraph;
  List<SubOfficeCodes>? subOfficeCodes;
  LineGraphData? lineGraphData;
  List<BarEntryDataList>? barEntryDataList;

  BarGraphData copyWith({
    String? explorePath,
    String? title,
    String? ofccode,
    List<String>? xAxisValues,
    String? typeOfGraph,
    List<SubOfficeCodes>? subOfficeCodes,
    LineGraphData? lineGraphData,
    List<BarEntryDataList>? barEntryDataList,
  }) =>
      BarGraphData(
        explorePath: explorePath ?? this.explorePath,
        title: title ?? this.title,
        ofccode: ofccode ?? this.ofccode,
        xAxisValues: xAxisValues ?? this.xAxisValues,
        typeOfGraph: typeOfGraph ?? this.typeOfGraph,
        subOfficeCodes: subOfficeCodes ?? this.subOfficeCodes,
        lineGraphData: lineGraphData ?? this.lineGraphData,
        barEntryDataList: barEntryDataList ?? this.barEntryDataList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['explorePath'] = explorePath;
    map['title'] = title;
    map['Ofccode'] = ofccode;
    map['xAxisValues'] = xAxisValues;
    map['typeOfGraph'] = typeOfGraph;
    if (subOfficeCodes != null) {
      map['subOfficeCodes'] = subOfficeCodes?.map((v) => v.toJson()).toList();
    }
    if (lineGraphData != null) {
      map['lineGraphData'] = lineGraphData?.toJson();
    }
    if (barEntryDataList != null) {
      map['barEntryDataList'] = barEntryDataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

LineGraphData lineGraphDataFromJson(String str) =>
    LineGraphData.fromJson(json.decode(str));

String lineGraphDataToJson(LineGraphData data) => json.encode(data.toJson());

class LineGraphData {
  LineGraphData({
    this.lineDataSets,
  });

  LineGraphData.fromJson(dynamic json) {
    if (json['lineDataSets'] != null) {
      lineDataSets = [];
      json['lineDataSets'].forEach((v) {
        lineDataSets?.add(LineDataSets.fromJson(v));
      });
    }
  }

  List<LineDataSets>? lineDataSets;

  LineGraphData copyWith({
    List<LineDataSets>? lineDataSets,
  }) =>
      LineGraphData(
        lineDataSets: lineDataSets ?? this.lineDataSets,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (lineDataSets != null) {
      map['lineDataSets'] = lineDataSets?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

LineDataSets lineDataSetsFromJson(String str) =>
    LineDataSets.fromJson(json.decode(str));

String lineDataSetsToJson(LineDataSets data) => json.encode(data.toJson());

class LineDataSets {
  LineDataSets({
    this.lineDataList,
    this.label,
  });

  LineDataSets.fromJson(dynamic json) {
    if (json['lineDataList'] != null) {
      lineDataList = [];
      json['lineDataList'].forEach((v) {
        lineDataList?.add(LineDataList.fromJson(v));
      });
    }
    label = json['label'];
  }

  List<LineDataList>? lineDataList;
  String? label;

  LineDataSets copyWith({
    List<LineDataList>? lineDataList,
    String? label,
  }) =>
      LineDataSets(
        lineDataList: lineDataList ?? this.lineDataList,
        label: label ?? this.label,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (lineDataList != null) {
      map['lineDataList'] = lineDataList?.map((v) => v.toJson()).toList();
    }
    map['label'] = label;
    return map;
  }
}

LineDataList lineDataListFromJson(String str) =>
    LineDataList.fromJson(json.decode(str));

String lineDataListToJson(LineDataList data) => json.encode(data.toJson());

class LineDataList {
  LineDataList({
    this.x,
    this.y,
  });

  LineDataList.fromJson(dynamic json) {
    x = json['x'];
    y = json['y'];
  }

  double? x;
  double? y;

  LineDataList copyWith({
    double? x,
    double? y,
  }) =>
      LineDataList(
        x: x ?? this.x,
        y: y ?? this.y,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['x'] = x;
    map['y'] = y;
    return map;
  }
}

SubOfficeCodes subOfficeCodesFromJson(String str) =>
    SubOfficeCodes.fromJson(json.decode(str));

String subOfficeCodesToJson(SubOfficeCodes data) => json.encode(data.toJson());

class SubOfficeCodes {
  SubOfficeCodes({
    this.optionId,
    this.optionName,
  });

  SubOfficeCodes.fromJson(dynamic json) {
    optionId = json['optionId'];
    optionName = json['optionName'];
  }

  String? optionId;
  String? optionName;

  SubOfficeCodes copyWith({
    String? optionId,
    String? optionName,
  }) =>
      SubOfficeCodes(
        optionId: optionId ?? this.optionId,
        optionName: optionName ?? this.optionName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionId'] = optionId;
    map['optionName'] = optionName;
    return map;
  }
}

class BarEntryDataList {
  BarEntryDataList({
    this.barEntriesList,
    this.label,
  });

  BarEntryDataList.fromJson(dynamic json) {
    if (json['barEntriesList'] != null) {
      barEntriesList = [];
      json['barEntriesList'].forEach((v) {
        barEntriesList?.add(BarEntriesList.fromJson(v));
      });
    }
    label = json['label'];
  }

  List<BarEntriesList>? barEntriesList;
  String? label;

  BarEntryDataList copyWith({
    List<BarEntriesList>? barEntriesList,
    String? label,
  }) =>
      BarEntryDataList(
        barEntriesList: barEntriesList ?? this.barEntriesList,
        label: label ?? this.label,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (barEntriesList != null) {
      map['barEntriesList'] = barEntriesList?.map((v) => v.toJson()).toList();
    }
    map['label'] = label;
    return map;
  }
}

class BarEntriesList {
  BarEntriesList({
    this.x,
    this.y,
  });

  BarEntriesList.fromJson(dynamic json) {
    x = json['x'];
    y = json['y'];
  }

  double? x;
  double? y;

  BarEntriesList copyWith({
    double? x,
    double? y,
  }) =>
      BarEntriesList(
        x: x ?? this.x,
        y: y ?? this.y,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['x'] = x;
    map['y'] = y;
    return map;
  }
}
