import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:knovator_app/bloc/post_event.dart';
import 'package:knovator_app/bloc/post_state.dart';
import 'package:knovator_app/models/post.dart';
import 'package:knovator_app/repository/PostsRepository.dart';
import 'package:knovator_app/utils/enum.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository postRepository = PostsRepository();
  final box1 = Hive.box('posts');
  final box2 = Hive.box('post');

  Map<int, Timer> timers = {};
  StreamController<int> timerStreamController =
      StreamController<int>.broadcast();

  PostBloc() : super(PostState()) {
    on<PostsFetched>(_fetchPosts);
    on<ChangeTileColor>(_changeTileColor);
    on<ToggleTimer>(_toggleTimer);
    on<UpdateTimer>(_updateTimer);
    on<PostFetched>(_fetchPost);
    timerStreamController.stream.listen((index) {
      add(UpdateTimer(index: index));
    });
  }

  Future<void> _fetchPosts(PostsFetched event, Emitter<PostState> emit) async {
    List<Post> postList = [];
    if (box1.isNotEmpty) {
      List<dynamic> retrievedList = await box1.get(1);
      postList = List<Post>.from(retrievedList.map((item) => item as Post));
      emit(state.copywith(
          postListStatus: PostStatus.success, postList: postList));
      postList = (await postRepository.getAllPosts())!;
      box1.put(1, postList);
    } else {
      emit(state.copywith(
        postListStatus: PostStatus.loading,
      ));
      postList = (await postRepository.getAllPosts())!;
      box1.put(1, postList);
      emit(state.copywith(
          postListStatus: PostStatus.success, postList: postList));
    }
  }

  Future<void> _fetchPost(PostFetched event, Emitter<PostState> emit) async {
    Post? post;
    if (box2.isNotEmpty && box2.get(event.postId) != null) {
      var retrievedItem = await box2.get(event.postId);
      post = retrievedItem as Post;
      emit(state.copywith(postStatus: PostStatus.success, post: post));
      post = (await postRepository.getPost(event.postId))!;
      box2.put(event.postId, post);
    } else {
      emit(state.copywith(
        postStatus: PostStatus.loading,
      ));
      post = (await postRepository.getPost(event.postId))!;
      box2.put(event.postId, post);
      emit(state.copywith(postStatus: PostStatus.success, post: post));
    }
  }

  void _changeTileColor(ChangeTileColor event, Emitter<PostState> emit) {
    List<Post> postList = List.from(state.postList);
    postList[event.index].tileColor = Colors.white.value;
    emit(state.copywith(postList: postList));
  }

  void _toggleTimer(ToggleTimer event, Emitter<PostState> emit) {
    List<Post> postList = List.from(state.postList);
    if (event.isVisible) {
      if (postList[event.index].timerItem!.isPaused!) {
        postList[event.index].timerItem!.isPaused = false;
        emit(state.copywith(postList: List.from(postList)));
        _startTimer(event.index);
      }
    } else {
      postList[event.index].timerItem!.isPaused = true;
      emit(state.copywith(postList: List.from(postList)));

      _stopTimer(event.index);
    }
  }

  void _startTimer(int index) {
    _stopTimer(index);
    timers[index] = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerStreamController.sink.add(index);
    });
  }

  void _stopTimer(int index) {
    timers[index]?.cancel();
    timers.remove(index);
  }

  void _updateTimer(UpdateTimer event, Emitter<PostState> emit) {
    List<Post> postList = List.from(state.postList);
    if (postList[event.index].timerItem!.isPaused! ||
        postList[event.index].timerItem!.duration == 0) {
      _stopTimer(event.index);
    } else {
      postList[event.index].timerItem!.duration =
          postList[event.index].timerItem!.duration! - 1;
      emit(state.copywith(postList: postList));
    }
  }

  @override
  Future<void> close() {
    timers.forEach((key, timer) => timer.cancel());
    timerStreamController.close();
    return super.close();
  }
}
