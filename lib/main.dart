import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:knovator_app/view/PostListScreen.dart';
import 'package:knovator_app/viewModel/PostViewModel.dart';
import 'package:provider/provider.dart';
import 'package:knovator_app/models/post.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox('posts');
  await Hive.openBox('post');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PostViewModel>(
            create: (context) => PostViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knovator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PostListScreen(),
    );
  }
}
