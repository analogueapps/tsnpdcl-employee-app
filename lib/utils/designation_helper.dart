// Designation Code Constants
const int CGM_DESIGNATION_CODE = 102;
const int EE_CIVIL_DESIGNATION_CODE = 111;

// Screen Identifiers
const int SCREEN_FOR_AE = 0;
const int SCREEN_FOR_CONS_AE = 1;
const int SCREEN_FOR_OM = 2;
const int SCREEN_FOR_ADE_OP = 3;
const int SCREEN_FOR_DE_OP = 4;
const int SCREEN_FOR_SE_OP = 5;
const int SCREEN_FOR_AE_OD = 6;
const int SCREEN_FOR_AE_SPM = 6; // Same as AE_OD
const int SCREEN_FOR_CGM = 7;
const int SCREEN_FOR_EE_CIVIL = 8;

// Designation Code to Screen Map
final Map<int, int> designationCodes = {
  150: SCREEN_FOR_AE,      // A.E
  155: SCREEN_FOR_AE,      // A.A.E
  165: SCREEN_FOR_AE,      // SUBENG
  510: SCREEN_FOR_OM,      // LI
  520: SCREEN_FOR_OM,      // L.M
  530: SCREEN_FOR_OM,      // ALM
  512: SCREEN_FOR_OM,      // CJLM
  524: SCREEN_FOR_OM,      // CJLM
  505: SCREEN_FOR_OM,      // CJLM
  513: SCREEN_FOR_OM,      // CJLM
  550: SCREEN_FOR_OM,      // CJLM
  545: SCREEN_FOR_OM,      // CJLM
  515: SCREEN_FOR_OM,      // CJLM
  555: SCREEN_FOR_OM,      // CJLM
  535: SCREEN_FOR_OM,      // CJLM
  519: SCREEN_FOR_OM,      // CJLM
  514: SCREEN_FOR_OM,      // CJLM
  521: SCREEN_FOR_OM,      // CJLM
  509: SCREEN_FOR_OM,      // CJLM
  500: SCREEN_FOR_OM,      // CJLM
  525: SCREEN_FOR_OM,      // CJLM
  523: SCREEN_FOR_OM,      // CJLM
  511: SCREEN_FOR_OM,      // CJLM
  522: SCREEN_FOR_OM,      // CJLM
  540: SCREEN_FOR_OM,      // CJLM
  125: SCREEN_FOR_ADE_OP,  // ADE
  110: SCREEN_FOR_DE_OP,   // DE
  106: SCREEN_FOR_SE_OP,   // SE
  105: SCREEN_FOR_SE_OP,   // SE
  102: SCREEN_FOR_CGM,     // CGM
  111: SCREEN_FOR_EE_CIVIL // EE Civil
};
