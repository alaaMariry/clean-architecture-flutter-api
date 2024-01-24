import 'package:del_clean_arc/core/app_theme.dart';
import 'package:del_clean_arc/features/post/domain/entites/post.dart';
import 'package:flutter/material.dart';


import '../../pages/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostAddUpdatePage(
                isUpdatePost: true,
                post: post,
              ),
            ));
      },
      icon:const Icon(Icons.edit , color: Colors.white,),
      label:const Text("Edit",style: TextStyle(color: Colors.white),),
    );
  }
}