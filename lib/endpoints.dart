const String baseURL = "http://chizaram-001-site1.atempurl.com";

/// AUTHENTICATION ENDPOINTS
/// Sign Up Endpoint
const String signUpEndpoint = "$baseURL + /api/Authentication/SignUp";

/// Login Endpoint
const String loginEndpoint = "$baseURL + /api/Authentication/SignUp";

/// Set PIN Endpoint
const String setPinEndpoint = "$baseURL + /api/Authentication/SetPin";

/// Change PIN Endpoint
const String changePinEndpoint = "$baseURL + /api/Authentication/ChangePin";

/// Send OTP Endpoint
const String sendOTPEndpoint = "$baseURL + /api/Authentication/SendOTP";

/// Validate OTP Endpoint
const String validateOTPEndpoint = "$baseURL + /api/Authentication/ValidateOTP";

/// Forgot Password Endpoint
const String forgotPasswordEndpoint =
    "$baseURL + /api/Authentication/ForgotPassword";

/// Change Password Endpoint
const String changePasswordEndpoint =
    "$baseURL + /api/Authentication/ChangePassword";

/// Get SubAccount Balance Endpoint
const String getSubAccountBalanceEndpoint =
    "$baseURL + /api/Authentication/GetSubAccountBalance";

/// DEPOSIT ENDPOINTS
/// Generate Ticket Endpoint
const String generateTicketEndpoint =
    "$baseURL + /api/Transaction/GenerateTicket";

/// Initiate Transfer Endpoint
const String initiatetransferEndpoint =
    "$baseURL + /api/Transaction/InitiateTransfer";

/// Delete Ticket Endpoint
const String deleteTicketEndpoint = "$baseURL + /api/Transaction/DeleteTicket";

/// Get Pending Transactions Endpoint
const String getPendingTransactionEndpoint =
    "$baseURL + /api/Transaction/GetPendingTransactions";

/// Get Transaction Endpoint
const String getTransactionEndpoint =
    "$baseURL + /api/Transaction/GetTransaction";

/// Get Pending Transactions Endpoint
const String getSubAccountEndpoint =
    "$baseURL + /api/Transaction/GetSubAccount";
