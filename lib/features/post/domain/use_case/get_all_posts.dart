import 'package:dartz/dartz.dart';
import 'package:del_clean_arc/core/errors/failures.dart';
import 'package:del_clean_arc/features/post/domain/entites/post.dart';
import 'package:del_clean_arc/features/post/domain/repositories/post_repositories.dart';

class GetAllPostUseCase {

  final PostRepositories repository;

  GetAllPostUseCase(this.repository);

  Future<Either<Failure,List<Post>>> call() async {
    return await repository.getAllPosts();
  }

}