const String baseURL = "http://petjohnson-001-site1.ctempurl.com";

/// AUTHENTICATION ENDPOINTS
/// Sign Up Endpoint
const String signUpEndpoint = "$baseURL/api/Authentication/SignUp";

/// Login Endpoint
const String loginEndpoint = "$baseURL/api/Authentication/Login";

/// Set PIN Endpoint
const String setPinEndpoint = "$baseURL/api/Authentication/SetPin";

/// Change PIN Endpoint
const String changePinEndpoint = "$baseURL/api/Authentication/ChangePin";

/// Send OTP Endpoint
const String sendOTPEndpoint = "$baseURL/api/Authentication/SendOTP";

/// Validate OTP Endpoint
const String validateOTPEndpoint = "$baseURL/api/Authentication/ValidateOTP";

/// Forgot Password Endpoint
const String forgotPasswordEndpoint =
    "$baseURL/api/Authentication/ForgotPassword";

/// Change Password Endpoint
const String changePasswordEndpoint =
    "$baseURL/api/Authentication/ChangePassword";

/// Get SubAccount Balance Endpoint
const String getSubAccountBalanceEndpoint =
    "$baseURL/api/Authentication/GetSubAccountBalance";

/// TRANSACTION ENDPOINTS
/// Generate Ticket Endpoint
const String generateTicketEndpoint = "$baseURL/api/Transaction/GenerateTicket";

/// Initiate Transfer Endpoint
const String initiatetransferEndpoint =
    "$baseURL/api/Transaction/InitiateTransfer";

/// Delete Ticket Endpoint
const String deleteTicketEndpoint = "$baseURL/api/Transaction/DeleteTicket";

/// Get Pending Transactions Endpoint
const String getPendingTransactionEndpoint =
    "$baseURL/api/Transaction/GetUsersPendingTransactions";

/// Get Transaction Endpoint
const String getTransactionEndpoint =
    "$baseURL/api/Transaction/GetUsersTransactions";

/// Get Transaction Endpoint
const String getScannedTransactionEndpoint =
    "$baseURL/api/Transaction/GetTransaction";

/// Get Pending Transactions Endpoint
const String getSubAccountEndpoint = "$baseURL/api/Transaction/GetSubAccount";

/// Fund Wallet
const String fundWalletEndpoint = "$baseURL/api/Transaction/FundWallet";

/// Generate EOD
const String generateEodEndpoint = "$baseURL/api/Transaction/GenerateEod";

/// Get Banks
const String getBankEndpoint = "$baseURL/api/Transaction/GetBanks";

/// Resolve Account Details
const String resolveAccountDetailsEndpoint =
    "$baseURL/api/Transaction/ResolveBankAccountDetails";

/// Withdraw from Wallet
const String withdrawEndpoint = "$baseURL/api/Transaction/WithdrawFromWallet";

/// Confirm Payment
const String confirmPaymentEndpoint =
    "$baseURL/api/Transaction/ConfirmTicketPayment";
