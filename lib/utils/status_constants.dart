class StatusConstants {
  static const String REQUESTED = "REQUESTED";
  static const String APPROVED = "APPROVED";
  static const String ADE_APPROVED = "ADE_APPROVED";
  static const String ADE_REJECTED = "ADE_REJECTED";
  static const String AE_REJECTED = "AE_REJECTED";
  static const String CB_OPEN = "CB_OPEN";
  static const String CB_OPEN_LM_AB_OPN = "CB_OPEN_LM_AB_OPN";
  static const String CB_OPEN_LM_SCADA_BREAKER_LOCAL_DONE = "CB_OPEN_LM_SCADA_BREAKER_LOCAL_DONE";
  static const String CB_OPEN_FS_LOCAL_EARTH_DONE = "CB_OPEN_FS_LOCAL_EARTH_DONE";
  static const String CB_OPEN_FS_LOCAL_EARTH_RMVD = "CB_OPEN_FS_LOCAL_EARTH_RMVD";
  static const String CB_OPEN_LM_SCADA_BREAKER_REMOTE_DONE = "CB_OPEN_LM_SCADA_BREAKER_REMOTE_DONE";
  static const String CB_OPEN_LM_AB_CLOSED = "CB_OPEN_LM_AB_CLOSED";
  static const String CB_OPEN_AE_CB_CLSD_REQ = "CB_OPEN_AE_CB_CLSD_REQ";
  static const String CLOSED = "CLOSED";
  static const String FORWARD_TO_ADE = "FORWARD_TO_ADE";

  static String getStatusMeaning(String status) {
    switch (status) {
      case REQUESTED:
        return "Requested";
      case APPROVED:
        return "Approved";
      case CB_OPEN:
        return "C.B Opened";
      case CB_OPEN_LM_AB_OPN:
        return "A/B SW. Opened";
      case CB_OPEN_LM_SCADA_BREAKER_LOCAL_DONE:
        return "Breaker in Local";
      case CB_OPEN_FS_LOCAL_EARTH_DONE:
        return "Earthing Done";
      case CB_OPEN_FS_LOCAL_EARTH_RMVD:
        return "Earthing Removed";
      case CB_OPEN_LM_SCADA_BREAKER_REMOTE_DONE:
        return "Breaker in Remote";
      case CB_OPEN_LM_AB_CLOSED:
        return "A/B SW. Closed";
      case CB_OPEN_AE_CB_CLSD_REQ:
        return "CB CLS REQ.";
      case CLOSED:
        return "CB Closed";
      default:
        return "N/A";
    }
  }

  static const String PENDING_DUMPS = "pending";
  static const String VERIFED_DUMPS = "verified";
  static const String MISMATCH_DUMPS = "mismatch";

  static String getPoleDumpedLocationTitle(String status) {
    switch (status) {
      case PENDING_DUMPS:
        return "Verification Pending";
      case VERIFED_DUMPS:
        return "Verified Dumps";
      case MISMATCH_DUMPS:
        return "Mismatched Dumps";
      default:
        return "N/A";
    }
  }

  static const String TYPE_PENDING_INSPECTION = "pendingInspection";
  static const String TYPE_INSPECTION_DONE = "inspectionDone";
  static const String TYPE_TO_BE_MAINTAINED = "toBeMaintained";
  static const String TYPE_MAINTENANCE_DONE = "maintenanceDone";

  static String getDTRInspectionListScreenTitle(String status) {
    switch (status) {
      case TYPE_PENDING_INSPECTION:
        return "Under Inspection";
      case TYPE_INSPECTION_DONE:
        return "Inspection Completed";
      case TYPE_TO_BE_MAINTAINED:
        return "Maintenance Due";
      case TYPE_MAINTENANCE_DONE:
        return "Maintenance Completed";
      default:
        return "N/A";
    }
  }

  //DTR Failure * BHAVANA
  static const String TYPE_FAILURE_REPORTS = "dtrFailureReports";
  static const String TYPE_VIEW_REPORTS = "viewFailureReports";
  static const String TYPE_VIEW_RECTIFIED = "viewRectifiedReports";

  static String getDTRFailureListScreenTitle(String status) {
    switch (status) {
      case TYPE_FAILURE_REPORTS:
        return "Failure Reporting";
      case TYPE_VIEW_REPORTS:
        return "View Failure Reports";
      case TYPE_VIEW_RECTIFIED:
        return "View Rectified";
      default:
        return "N/A";
    }
  }
}
