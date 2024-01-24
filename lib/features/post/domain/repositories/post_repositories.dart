import 'package:dartz/dartz.dart';
import 'package:del_clean_arc/core/errors/failures.dart';
import 'package:del_clean_arc/features/post/domain/entites/post.dart';

abstract class PostRepositories{

  Future<Either<Failure,List<Post>>>getAllPosts();

  Future<Either<Failure,Unit>>deletePost(int id);

  Future<Either<Failure,Unit>>updatePost(Post post);


  Future<Either<Failure,Unit>>addPost(Post post);



}