import '../models/post.dart';
import '../utils/enum.dart';

class PostState {
  final PostStatus postListStatus;
  final List<Post> postList;
  final PostStatus postStatus;
  Post? post;

  PostState(
      {this.postList = const [],
      this.postListStatus = PostStatus.loading,
      this.postStatus = PostStatus.loading,
      this.post});

  PostState copywith(
      {PostStatus? postListStatus,
      List<Post>? postList,
      PostStatus? postStatus,
      Post? post}) {
    return PostState(
        postList: postList ?? this.postList,
        postListStatus: postListStatus ?? this.postListStatus,
        postStatus: postStatus ?? this.postStatus,
        post: post ?? this.post);
  }

  // TODO: implement props
  List<Object?> get props => [postListStatus, postList, postStatus, post];
}
