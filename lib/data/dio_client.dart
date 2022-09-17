import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class DioClient extends DioForNative {
  DioClient([BaseOptions? base]) : super(base = BaseOptions()) {
    /// dùng để config global như baseAPI, timeout, ...
  }
}
