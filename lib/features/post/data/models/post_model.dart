import 'package:del_clean_arc/features/post/domain/entites/post.dart';

class PostModel extends Post {
  const PostModel(
      { super.id, required super.body, required super.title});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], body: json['body'], title: json['title']);
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'body':body,
    };
  }

  toList() {}
}
