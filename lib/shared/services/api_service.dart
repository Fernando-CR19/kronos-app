import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? '',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      }
    )
  );

   Dio get client => _dio;
}
