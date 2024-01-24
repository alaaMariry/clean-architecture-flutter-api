import 'package:del_clean_arc/core/widgets/loading_widget.dart';
import 'package:del_clean_arc/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:del_clean_arc/features/post/presentation/pages/post_add_update_page.dart';
import 'package:del_clean_arc/features/post/presentation/widget/posts_page/message_display_widget.dart';
import 'package:del_clean_arc/features/post/presentation/widget/posts_page/posts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const PostAddUpdatePage(isUpdatePost: false) ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

 Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh:() => _onRefresh(context),
              child: PostListWidget(posts: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return Container(
            height: 100,width: 100,color: Colors.redAccent,
          );
        },
      ),
    );
  }

Future<void> _onRefresh(BuildContext context)async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
