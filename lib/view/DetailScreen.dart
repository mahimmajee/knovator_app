import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knovator_app/bloc/post_bloc.dart';
import 'package:knovator_app/bloc/post_event.dart';
import 'package:knovator_app/bloc/post_state.dart';
import 'package:knovator_app/utils/enum.dart';

class DetailScreen extends StatefulWidget {
  int? postId;

  DetailScreen({this.postId, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostBloc>().add(PostFetched(postId: widget.postId!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state.postStatus == PostStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : Text(state.post == null ? "NA" : state.post!.title!),
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
          ),
          body: state.postStatus == PostStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Card(
                    color: Colors.yellow[100],
                    child: Text(state.post == null ? "NA" : state.post!.body!),
                  ),
                ),
        );
      },
    );
  }
}
