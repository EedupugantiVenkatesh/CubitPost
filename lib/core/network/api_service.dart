import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<Response> get(String url) async {
    return await dio.get(url);
  }
}
