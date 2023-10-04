import 'package:dio/dio.dart';

extension IsOK on Response {
  bool get isOk => statusCode == 200;
}
