class DesignationUtils {
  // Check if the designation code belongs to AE
  static bool isAe(int designationCode) {
    return designationCode == 155 || designationCode == 150;
  }

  // Check if the designation code belongs to Sub Engineer
  static bool isSubEng(int designationCode) {
    return designationCode == 165;
  }

  // Check if the designation code belongs to ADE
  static bool isAde(int designationCode) {
    return designationCode == 125;
  }

  // Check if the designation code belongs to CGM
  static bool isCgm(int designationCode) {
    return designationCode == 102;
  }

  // Check if the designation code belongs to EE
  static bool isEE(int designationCode) {
    return designationCode == 111;
  }

  // Check if the wing is Operation Wing
  static bool isOperationWing(String wing) {
    return wing.toLowerCase() == "operation";
  }

  // Check if the wing is Store Wing
  static bool isStoreWing(String wing) {
    return wing.toLowerCase() == "store";
  }

  // Check if the wing is Civil Wing
  static bool isCivilWing(String wing) {
    return wing.toLowerCase() == "civil";
  }

  // Check if the wing is PMM Wing
  static bool isPMMWing(String wing) {
    return wing.toLowerCase() == "pmm";
  }
}
