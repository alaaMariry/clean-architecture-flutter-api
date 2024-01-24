// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// import 'package:flutter/foundation.dart';
import 'package:del_clean_arc/features/post/presentation/pages/post_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:del_clean_arc/features/post/domain/entites/post.dart';

class PostListWidget extends StatelessWidget {
  List<Post> posts;
  PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle:
                Text(posts[index].body, style: const TextStyle(fontSize: 16)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => PostDetailPage(post: posts[index])));
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1),
        itemCount: posts.length);
  }
}
