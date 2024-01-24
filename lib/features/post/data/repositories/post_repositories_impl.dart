import 'package:dartz/dartz.dart';
import 'package:del_clean_arc/core/errors/exception.dart';
import 'package:del_clean_arc/core/errors/failures.dart';
import 'package:del_clean_arc/core/network/network_info.dart';
import 'package:del_clean_arc/features/post/data/data_sources/post_local_data_source.dart';
import 'package:del_clean_arc/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:del_clean_arc/features/post/data/models/post_model.dart';
import 'package:del_clean_arc/features/post/domain/entites/post.dart';
import 'package:del_clean_arc/features/post/domain/repositories/post_repositories.dart';

class PostsRepositoryImpl implements PostRepositories {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localeDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localeDataSource});
  // هون بحكي مع الداتا سورس يلي عندي اذا لوكال او ا بي اي
  //بدي اتاكد من حالة الانترنت
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePost = await remoteDataSource.getAllPost();
        localeDataSource.cachePost(remotePost); //مشان تنحفظ بالجهاز
        return Right(remotePost); //مشلن رجع الداتا
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPost = await localeDataSource.getCachedPosts();
        return Right(localPost);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(body: post.body, title: post.title);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addPost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.deletePost(postId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, body: post.body, title: post.title);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updatePost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
