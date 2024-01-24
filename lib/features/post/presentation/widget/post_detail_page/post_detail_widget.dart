
import 'package:del_clean_arc/features/post/domain/entites/post.dart';
import 'package:del_clean_arc/features/post/presentation/widget/post_detail_page/delete_post_btn_widget.dart';
import 'package:del_clean_arc/features/post/presentation/widget/post_detail_page/update_post_btn_widget.dart';
import 'package:flutter/material.dart';


class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style:const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
         const Divider(
            height: 50,
          ),
          Text(
            post.body,
            style:const TextStyle(
              fontSize: 16,
            ),
          ),
         const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!)
            ],
          )
        ],
      ),
    );
  }
}