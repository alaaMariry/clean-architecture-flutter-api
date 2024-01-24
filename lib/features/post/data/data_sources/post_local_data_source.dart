// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:del_clean_arc/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:del_clean_arc/features/post/data/models/post_model.dart';

abstract class PostLocalDataSource {
//بدي اكتب الدوال يلي انا بحاجتها
//هون بدي دالة تحفظلي البيانات بالجهاز
//و تابع تاني يرجعلي البيانات يلي انا حفظتها

  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePost(List<PostModel> postModel);
}

const CACHED_POSTS= "CACHED_POSTS";
/// اول شي بدي حول
/// list<POstModel>
/// الى ماب
///
class PostLocalDataSourceImpl implements PostLocalDataSource {
  SharedPreferences sharedPreferences;
  PostLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<Unit> cachePost(List<PostModel> postModel) {
    List postModelsToJson = postModel
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModel = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
          return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
    // throw UnimplementedError();
  }
}
