import 'package:dio/dio.dart';

String handleError(Error error) {
  String errorDescription = "";
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Request to API took too long";
        break;
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
        "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription =
        "Received invalid status code: ${error.response.statusCode}";
        break;
    }
  } else {
    errorDescription = "Unexpected error occured";
  }
  return errorDescription;
}