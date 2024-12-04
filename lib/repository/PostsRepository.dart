import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:knovator_app/models/post.dart';

class PostsRepository {
  Future<List<Post>?> getAllPosts() async {
    List<Post> postList = [];
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).timeout(
      const Duration(seconds: 600),
      onTimeout: () => throw TimeoutException('Can\'t connect in 600 seconds.'),
    );
    try {
      if (response.statusCode == 200) {
        var perf = json.decode(response.body);
        for (var post in perf) {
          postList.add(Post.fromJson(post));
        }
        return postList;
      } else {
        debugPrint(
            "Get getAllPost Request Status Code =====> ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception during getting getAllPost Request =========> $e");
      return null;
    }
  }

  Future<Post?> getPost(int postId) async {
    Post? post;
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).timeout(
      const Duration(seconds: 600),
      onTimeout: () => throw TimeoutException('Can\'t connect in 600 seconds.'),
    );
    try {
      if (response.statusCode == 200) {
        var perf = json.decode(response.body);
        post = Post.fromJson(perf);
        return post;
      } else {
        debugPrint(
            "Get getPost Request Status Code =====> ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception during getting getPost Request =========> $e");
      return null;
    }
  }
}
