import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  Dio dio = Dio();
  ApiService() {
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        }));
  }
  Future<Response> post(
      {required body,
      required String url,
      required String token,
        Map<String, dynamic>? headers,
      String? contentType}) async {
    var response = await dio.post(url,
        data: body,
        options: Options(
            headers:headers?? {'Authorization': "Bearer $token"},
            contentType: contentType));
    return response;
  }
}
