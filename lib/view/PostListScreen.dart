import 'package:flutter/material.dart';
import 'package:knovator_app/view/DetailScreen.dart';
import 'package:knovator_app/viewModel/PostViewModel.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
    var provider = Provider.of<PostViewModel>(context, listen: false);
    provider.initialClear();
    provider.readPostsFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Posts"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Consumer<PostViewModel>(builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            provider.postListLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.postList.isEmpty
                    ? const Center(
                        child: Text('No Posts Available'),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: provider.postList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: VisibilityDetector(
                                key: Key('item-$index'),
                                onVisibilityChanged: (visibilityInfo) {
                                  final isVisible =
                                      visibilityInfo.visibleFraction > 0;
                                  provider.toggleTimer(index, isVisible);
                                },
                                child: ListTile(
                                  title: Text(provider.postList[index].title ??
                                      'No Title'),
                                  tileColor: provider.tileColor[index],
                                  onTap: () {
                                    provider.changeTileColor(index);
                                    provider.toggleTimer(index, true);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            postId:
                                                provider.postList[index].id),
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
                                        provider.timerItems[index].duration
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
      }),
    );
  }
}
