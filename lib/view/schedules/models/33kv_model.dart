class InspectionItem {
  final String name;
  bool isChecked;

  InspectionItem(this.name, {this.isChecked = false});
}
class SSMaintenanceAttributesEntity {
  String? attributeType;
  String? attributeName;
  String? attributeValue;
  String? instance;
  String? ssCode;

  SSMaintenanceAttributesEntity({
    this.attributeType,
    this.attributeName,
    this.attributeValue,
    this.instance,
    this.ssCode,
  });

  Map<String, dynamic> toJson() {
    return {
      "attributeType": attributeType,
      "attributeName": attributeName,
      "attributeValue": attributeValue,
      "instance": instance,
      "ssCode": ssCode,
    };
  }
}
class AttributeCheckbox {
  final String name;
  bool isChecked;

  AttributeCheckbox({required this.name, this.isChecked = false});
}

class SSMaintenanceEntity {
  String? ssCode;
  List<SSMaintenanceAttributesEntity>? attributes;

  SSMaintenanceEntity({
    this.ssCode,
    this.attributes,
  });

  Map<String, dynamic> toJson() => {
    "ssCode": ssCode,
    "ssMaintenanceAttributesEntitiesByMid":
    attributes?.map((e) => e.toJson()).toList(),
  };
}

class CheckboxData {
  String label;
  bool checked;

  CheckboxData({required this.label, required this.checked});
}


