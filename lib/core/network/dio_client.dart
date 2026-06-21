import 'package:dio/dio.dart';
import 'package:shopease/core/constants/app_constants.dart';

class DioClient {
  DioClient._();

  /// Singleton instance of DioClient
  static final Dio instance = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: duration(),
      receiveTimeout: duration(),
      sendTimeout: duration(),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static Duration duration() => const Duration(seconds: 30);
}
