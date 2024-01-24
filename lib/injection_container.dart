import 'package:del_clean_arc/core/network/network_info.dart';
import 'package:del_clean_arc/features/post/data/data_sources/post_local_data_source.dart';
import 'package:del_clean_arc/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:del_clean_arc/features/post/data/repositories/post_repositories_impl.dart';
import 'package:del_clean_arc/features/post/domain/repositories/post_repositories.dart';
import 'package:del_clean_arc/features/post/domain/use_case/add_post.dart';
import 'package:del_clean_arc/features/post/domain/use_case/delete_post.dart';
import 'package:del_clean_arc/features/post/domain/use_case/get_all_posts.dart';
import 'package:del_clean_arc/features/post/domain/use_case/update_post.dart';
import 'package:del_clean_arc/features/post/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:del_clean_arc/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async{
  //! Featers : posts

  //bloc
  sl.registerFactory(() => PostsBloc(getAllPost: sl()));
  sl.registerFactory(
    () => AddDeleteUpdateBloc(
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl(),
    ),
  );

  // Use_Case
  sl.registerLazySingleton(() => GetAllPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  //Repository

  sl.registerLazySingleton<PostRepositories>(() => PostsRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localeDataSource: sl()));

  //Data_Source
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! external
  final sharedPreferences  = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences );
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
