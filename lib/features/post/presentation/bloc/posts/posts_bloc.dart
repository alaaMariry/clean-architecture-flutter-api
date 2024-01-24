// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:del_clean_arc/core/errors/failures.dart';
import 'package:del_clean_arc/core/strings/failure.dart';
import 'package:equatable/equatable.dart';

import 'package:del_clean_arc/features/post/domain/entites/post.dart';
import 'package:del_clean_arc/features/post/domain/use_case/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostUseCase getAllPost;
  PostsBloc({
    required this.getAllPost,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState()); //لبين ما تتحمل الداتا
        final failureOrposts = await getAllPost();
        failureOrposts.fold(
          (failure) {
            emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
          },
          (posts) {
            emit(LoadedPostsState(posts: posts));
          },
        );
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState()); //لبين ما تتحمل الداتا
        final failureOrposts = await getAllPost();
        failureOrposts.fold(
          (failure) {
            emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
          },
          (posts) {
            emit(LoadedPostsState(posts: posts));
          },
        );
      }
    });
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILUER_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "unexpected Error , Please try again later";
    }
  }
}
