import 'package:del_clean_arc/core/app_theme.dart';
import 'package:del_clean_arc/features/post/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:del_clean_arc/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:del_clean_arc/features/post/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di ;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<AddDeleteUpdateBloc>(),
        ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const PostsPage()
    ),
    );
    
    
  }
}
