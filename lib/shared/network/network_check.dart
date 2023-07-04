import 'dart:ui';

import 'package:dio/dio.dart';

class NetworksCheck{
  VoidCallback? onComplete;
  VoidCallback? onError;
  String? error;

  NetworksCheck({this.onComplete, this.onError,this.error = "something went wrong"});

  void doRequest() async{
    try {
      Dio dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 5); // Set a timeout of 5 seconds
      Response response = await dio.get('https://www.google.com');
      if(response.statusCode == 200){
        print('get ');
        onComplete!();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        onError!();
        error = e.message;
        print('Request timed out');
      } else if (e.type == DioErrorType.badResponse) {
        error = e.message;
        onError!();
        print('Response timed out');
      } else if (e.type == DioErrorType.receiveTimeout) {
        error = e.message;
        onError!();
        print('Error response received: ${e.response?.statusCode}');
        error = e.message;
        onError!();
      } else if (e.type == DioErrorType.cancel) {
        error = e.message;
        onError!();
        print('Request was cancelled');
      } else {
        onError!();
        print('Other error occurred: ${e.message}');
        error = e.message;
      }
    } catch (e) {
      print('Unexpected error occurred: ${e.toString()}');
      error = e.toString();
      onError!();
    }
  }
}