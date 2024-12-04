import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:knovator_app/models/post.dart';
import 'package:knovator_app/repository/PostsRepository.dart';
import '../models/TimerItem.dart';

class PostViewModel with ChangeNotifier {
  final postRepository = PostsRepository();
  bool postListLoading = false;
  bool postLoading = false;
  final box1 = Hive.box('posts');
  final box2 = Hive.box('post');
  Random random = Random();

  List<Post> postList = [];
  Post? post;
  List<Color> tileColor = [];
  List<TimerItem> timerItems = [];

  getPostList() async {
    postListLoading = true;
    postList = (await postRepository.getAllPosts())!;
    box1.put(1, postList);
    tileColor = List<Color>.filled(postList.length, Colors.yellow[100]!);
    timerItems = List.generate(
      postList.length,
      (index) => TimerItem(
          duration: random.nextInt(2) == 0
              ? 10
              : random.nextInt(2) == 1
                  ? 20
                  : 25),
    );
    postListLoading = false;
    notifyListeners();
  }

  getPost(int postId) async {
    postLoading = true;
    post = (await postRepository.getPost(postId))!;
    box2.put(postId, post);
    postLoading = false;
    notifyListeners();
  }

  changeTileColor(int index) {
    tileColor[index] = Colors.white;
    notifyListeners();
  }

  void toggleTimer(int index, bool isVisible) {
    if (isVisible) {
      if (timerItems[index].isPaused!) {
        timerItems[index].isPaused = false;
        _startTimer(index);
      }
    } else {
      timerItems[index].isPaused = true;
    }
    notifyListeners();
  }

  void _startTimer(int index) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerItems[index].isPaused! || timerItems[index].duration == 0) {
        timer.cancel();
      } else {
        timerItems[index].duration = timerItems[index].duration! - 1;
      }
      notifyListeners();
    });
  }

  readPostsFromLocal() async {
    if (box1.isNotEmpty) {
      List<dynamic> retrievedList = await box1.get(1);
      postList = List<Post>.from(retrievedList.map((item) => item as Post));
      tileColor = List<Color>.filled(postList.length, Colors.yellow[100]!);
      timerItems = List.generate(
        postList.length,
        (index) => TimerItem(
            duration: random.nextInt(2) == 0
                ? 10
                : random.nextInt(2) == 1
                    ? 20
                    : 25),
      );
      notifyListeners();
      postList = (await postRepository.getAllPosts())!;
      tileColor = List<Color>.filled(postList.length, Colors.yellow[100]!);
      timerItems = List.generate(
        postList.length,
        (index) => TimerItem(
            duration: random.nextInt(2) == 0
                ? 10
                : random.nextInt(2) == 1
                    ? 20
                    : 25),
      );
    } else {
      getPostList();
    }
  }

  readPostFromLocal(int postId) async {
    if (box2.isNotEmpty && box2.get(postId) != null) {
      var retrievedItem = await box2.get(postId);
      post = retrievedItem as Post;
      notifyListeners();
      post = (await postRepository.getPost(postId))!;
    } else {
      getPost(postId);
    }
  }

  void initialClear() {
    postList.clear();
    timerItems.clear();
    tileColor.clear();
  }
}
