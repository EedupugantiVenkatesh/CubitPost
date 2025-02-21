import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/presentation/cubit/post_cubit.dart';
import 'features/posts/domain/usecases/get_posts.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/data/datasources/post_remote_data_source.dart';
import 'core/network/api_service.dart';
import 'features/posts/presentation/pages/post_page.dart';
import 'package:dio/dio.dart';

void main() {
  final repository = PostRepositoryImpl(remoteDataSource: PostRemoteDataSourceImpl(apiService: ApiService(dio: Dio())));
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final PostRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: BlocProvider(
        create: (_) => PostCubit(getPosts: GetPosts(repository)),
        child: PostPage(),
      ),
    );
  }
}
