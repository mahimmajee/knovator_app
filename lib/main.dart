import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:knovator_app/bloc/post_bloc.dart';
import 'package:knovator_app/view/PostListScreen.dart';
import 'package:knovator_app/models/post.dart';
import 'models/TimerItem.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(TimerItemAdapter());
  await Hive.openBox('posts');
  await Hive.openBox('post');
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(),
      child: MaterialApp(
        title: 'Knovator App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const PostListScreen(),
      ),
    );
  }
}
