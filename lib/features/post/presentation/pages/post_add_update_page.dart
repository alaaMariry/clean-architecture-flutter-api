import 'package:del_clean_arc/features/post/domain/entites/post.dart';
import 'package:del_clean_arc/features/post/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:del_clean_arc/features/post/presentation/widget/post_add_update_page/form_widget.dart';

import '../../../../core/widgets/loading_widget.dart';
import 'posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbar_message.dart';
// import '../../domain/entities/post.dart';
// import '../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
// import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post",style:const TextStyle(color: Colors.white,),));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding:const EdgeInsets.all(10),
          child:
              BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdateState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) =>const PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdateState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          )),
    );
  }
}