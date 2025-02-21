import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final result = await remoteDataSource.getPosts();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString())); // ✅ Pass the error message
    }
  }
}
