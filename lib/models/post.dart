import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:knovator_app/models/TimerItem.dart';
part 'post.g.dart';

Random random = Random();

@HiveType(typeId: 0)
class Post {
  @HiveField(0)
  int? userId;

  @HiveField(1)
  int? id;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? body;

  @HiveField(4)
  int? tileColor;

  @HiveField(5)
  TimerItem? timerItem;

  Post(
      {this.userId,
      this.id,
      this.title,
      this.body,
      this.tileColor,
      this.timerItem});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] as int?;
    id = json['id'] as int?;
    title = json['title'] as String?;
    body = json['body'] as String?;
    tileColor = Colors.yellow[100]!.value;
    timerItem = TimerItem(
      duration: random.nextInt(2) == 0
          ? 10
          : random.nextInt(2) == 1
              ? 20
              : 25,
      isPaused: true,
    );
  }
}
