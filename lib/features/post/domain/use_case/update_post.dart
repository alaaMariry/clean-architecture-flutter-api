import 'package:dartz/dartz.dart';
import 'package:del_clean_arc/core/errors/failures.dart';
import 'package:del_clean_arc/features/post/domain/entites/post.dart';
import 'package:del_clean_arc/features/post/domain/repositories/post_repositories.dart';

class UpdatePostUseCase{

  final PostRepositories repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure,Unit>> call(Post post) async{
    return await repository.updatePost(post) ;
  }

}