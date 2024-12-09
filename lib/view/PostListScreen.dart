import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knovator_app/utils/enum.dart';
import 'package:knovator_app/view/DetailScreen.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostBloc>().add(PostsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Posts"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state.postListStatus == PostStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : state.postList.isEmpty
                      ? const Center(
                          child: Text('No Posts Available'),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: state.postList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: VisibilityDetector(
                                  key: Key('item-$index'),
                                  onVisibilityChanged: (visibilityInfo) {
                                    final isVisible =
                                        visibilityInfo.visibleFraction > 0;
                                    context.read<PostBloc>().add(ToggleTimer(
                                        index: index, isVisible: isVisible));
                                  },
                                  child: ListTile(
                                    title: Text(state.postList[index].title ??
                                        'No Title'),
                                    tileColor:
                                        Color(state.postList[index].tileColor!),
                                    onTap: () {
                                      context
                                          .read<PostBloc>()
                                          .add(ChangeTileColor(index: index));
                                      context.read<PostBloc>().add(ToggleTimer(
                                          index: index, isVisible: true));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                              postId: state.postList[index].id),
                                        ),
                                      );
                                    },
                                    trailing: Column(
                                      children: [
                                        const Icon(Icons.timer,
                                            color: Colors.orange),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          state.postList[index].timerItem!
                                              .duration!
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ],
          );
        },
      ),
    );
  }
}
