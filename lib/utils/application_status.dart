class ApplicationStatus {
  // Feasibility Status Constants
  static const String PENDING_FOR_FEASIBILITY_CHECK_ALLOTMENT = "VERIFIED";
  static const String UNDER_FEASIBILITY_CHECK = "F_ALLOT";
  static const String PENDING_FOR_FEASIBILITY_APPROVAL = "PFA"; // Pending for Feasibility Approval
  static const String FEASIBILITY_SUBMITTED_LIST = "FS"; // Feasibility Submitted List
  static const String LINE_MEN_FEASIBILITY_APPROVED = "LM_F";
  static const String LINE_MEN_FEASIBILITY_NOT_APPROVED = "LM_NF";
  static const String AE_FEASIBILITY_APPROVED = "AE_F";
  static const String AE_FEASIBILITY_NOT_APPROVED = "AE_NF";
  static const String METERS_ISSUED_BY_ADE = "APPROVED";
  static const String METERS_ISSUED_TO_OM_STAFF = "A_ALLOT";
  static const String METERS_FIXED_PENDING_FOR_RELEASE = "FIXED";
  static const String RELEASED = "REL";
  static const String REJECTED = "REJ";

  // Scheme Status Constants
  static const String REGISTERED_UNDER_SCHEME = "REGISTERED";
  static const String SCH_ALLOT = "SCH_ALLOT";
  static const String MTR_FIXED = "MTR_FIXED";
  static const String SEAL_ALLOT = "SEAL_ALLOT";
  static const String SEAL_FIXED = "SEAL_FIXED";
  static const String SCH_REL = "REL";


  static String getApplicationStatusName(String status) {
    switch (status) {
      case ApplicationStatus.PENDING_FOR_FEASIBILITY_CHECK_ALLOTMENT:
        return "Pending F.C Allotment By AE";
      case ApplicationStatus.UNDER_FEASIBILITY_CHECK:
        return "Under Feasibility Check By O&M";
      case ApplicationStatus.PENDING_FOR_FEASIBILITY_APPROVAL:
        return "Pending For Feasibility By AE";
      case ApplicationStatus.METERS_ISSUED_BY_ADE:
        return "Meters to be Allotted by AE";
      case ApplicationStatus.METERS_ISSUED_TO_OM_STAFF:
        return "Meters to be fixed by O&M";
      case ApplicationStatus.METERS_FIXED_PENDING_FOR_RELEASE:
        return "Meters Installed To Be Released By AE";
      case ApplicationStatus.RELEASED:
        return "Released Services";
      case ApplicationStatus.REJECTED:
        return "Rejected Applications";
      case ApplicationStatus.AE_FEASIBILITY_APPROVED:
        return "Meters Allotment Pending by ADE";
      case ApplicationStatus.AE_FEASIBILITY_NOT_APPROVED:
        return "Feasibility Not Approved By AE";
      case ApplicationStatus.REGISTERED_UNDER_SCHEME:
        return "Registered Applications";
      case ApplicationStatus.SCH_ALLOT:
        return "Applications with AE/CON";
      case ApplicationStatus.MTR_FIXED:
        return "Meters Fixed";
      case ApplicationStatus.SEAL_ALLOT:
        return "Allotted For Sealing";
      case ApplicationStatus.SEAL_FIXED:
        return "To Be Release";
      default:
        return "List";
    }
  }
}
