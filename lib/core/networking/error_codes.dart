class ErrorCodes {
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found

  // local status code
  static const int unknown = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int recieveTimeout = -4;
  static const int sendTimeout = -5;
  static const int noInternetConnection = -6;
}
