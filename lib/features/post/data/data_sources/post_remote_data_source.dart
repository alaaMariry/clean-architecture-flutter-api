// ignore_for_file: constant_identifier_names

import 'dart:convert';
// import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:del_clean_arc/core/errors/exception.dart';
import 'package:del_clean_arc/features/post/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
//الدوال يلي انا بطلبها من ال
//api

  Future<List<PostModel>> getAllPost();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const BASE_URL ="https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
   final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPost() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/posts/'),
      headers: {"Content_Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List; //map
      final List<PostModel> postModels = decodeJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {'title': postModel.title, 'body': postModel.body};

    final respnse =
        await client.post(Uri.parse('$BASE_URL/posts/'), body: body);
    if (respnse.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse('$BASE_URL/posts/${postId.toString()}'),
      headers: {"Content_Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {'title': postModel.title, 'body': postModel.body};
    final response =
        await client.patch(Uri.parse('$BASE_URL/posts/$postId'), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}





/**عملت هاد الكلاس 
 * abstract
 * لانو ممكن اعمل 
 * implements
 * لاكتر من كلاس تاني
 * متل
 * http -- dio
 * يعني لانو ابستراكت فيني اعملو ايمبيمنت عدد لانهائي من المرات
 */