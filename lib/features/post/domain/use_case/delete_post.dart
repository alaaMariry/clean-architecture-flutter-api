import 'package:dartz/dartz.dart';
import 'package:del_clean_arc/core/errors/failures.dart';
import 'package:del_clean_arc/features/post/domain/repositories/post_repositories.dart';

class DeletePostUseCase {

  final PostRepositories repository;

  DeletePostUseCase(this.repository);
  
  Future<Either<Failure,Unit>> call(int postId) async{
   return await repository.deletePost(postId) ;
  }

}