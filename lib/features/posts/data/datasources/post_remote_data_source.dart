import 'package:dio/dio.dart';
import '../../../../core/network/api_service.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiService apiService;

  PostRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await apiService.get("https://jsonplaceholder.typicode.com/posts");
    return (response.data as List).map((json) => PostModel.fromJson(json)).toList();
  }
}
