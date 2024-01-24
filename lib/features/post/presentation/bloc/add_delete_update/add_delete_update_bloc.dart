// ignore_for_file: constant_pattern_never_matches_value_type, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:del_clean_arc/core/errors/failures.dart';
import 'package:del_clean_arc/core/strings/failure.dart';
import 'package:del_clean_arc/core/strings/message.dart';
import 'package:del_clean_arc/features/post/domain/entites/post.dart';
import 'package:del_clean_arc/features/post/domain/use_case/add_post.dart';
import 'package:del_clean_arc/features/post/domain/use_case/delete_post.dart';
import 'package:del_clean_arc/features/post/domain/use_case/update_post.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  AddDeleteUpdateBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdateState());

        final failureOrMessage = await addPost(event.post);

        failureOrMessage.fold(
          (failure) => {
            emit(ErrorAddDeleteUpdateState(
                message: _mapFailureTpMessage(failure)))
          },
          (_) =>
              {emit(MessageAddDeleteUpdateState(message: ADD_SUCCESS_MESSAGE))},
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final failureOrMessage = await updatePost(event.post);
        failureOrMessage.fold(
          (failure) => {
            emit(ErrorAddDeleteUpdateState(
                message: _mapFailureTpMessage(failure)))
          },
          (_) => {
            emit(MessageAddDeleteUpdateState(message: UPDATE_SUCCESS_MESSAGE))
          },
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdateState());
        final failureOrMessage = await deletePost(event.postId);
        failureOrMessage.fold(
          (failure) => {
            emit(ErrorAddDeleteUpdateState(
                message: _mapFailureTpMessage(failure)))
          },
          (_) => {
            emit(MessageAddDeleteUpdateState(message: DELETE_SUCCESS_MESSAGE))
          },
        );
      }
    });
  }

  String _mapFailureTpMessage(Failure failure) {
    switch (failure) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "unexpected Error , Please try again later";
    }
  }
}
