import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_posts.dart';
import '../../domain/entities/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts); // Accepts a positional argument
}

class PostError extends PostState {
  final String message;
  PostError(this.message); // Accepts a positional argument
}

class PostCubit extends Cubit<PostState> {
  final GetPosts getPosts;
  List<Post> cachedPosts = []; // Store cached posts

  PostCubit({required this.getPosts}) : super(PostInitial());

  void fetchPosts({bool refresh = false}) async {
    if (cachedPosts.isNotEmpty && !refresh) {
      emit(PostLoaded(cachedPosts)); // ✅ Fixed constructor call
      return;
    }

    emit(PostLoading());
    final result = await getPosts();
    result.fold(
          (failure) => emit(PostError(failure.message)), // ✅ Fixed constructor call
          (posts) {
        cachedPosts = posts;
        emit(PostLoaded(posts)); // ✅ Fixed constructor call
      },
    );
  }
}
