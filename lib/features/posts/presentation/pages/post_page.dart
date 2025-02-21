import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/post_cubit.dart';
import '../widgets/post_list.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().fetchPosts(); // Load cached posts first
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading && context.read<PostCubit>().cachedPosts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostCubit>().fetchPosts(refresh: true);
              },
              child: PostList(posts: state.posts),
            );
          } else if (state is PostError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => context.read<PostCubit>().fetchPosts(refresh: true),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
