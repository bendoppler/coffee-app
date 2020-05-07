import 'package:cafe_app/widgets/utils/handle_error.dart';
import 'package:dio/dio.dart';

void setupInterceptor(Dio _dio) {
  int maxCharactersPerLine = 200;
  _dio.interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options){
      print("--> ${options.method} ${options.path}");
      print("Content type: ${options.contentType}");
      print("<-- END HTTP");
      return options;
    },
    onResponse:(Response response) {
      //use case for this is to Handle Global Error Handling across the app
      print(
        "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations =
        (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
            i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response.data);
      }
      print("<-- END HTTP");
    },
    onError: (DioError e) {
      // Do something with response error
      handleError(e);
      return  e;//continue
    }
  ));
}