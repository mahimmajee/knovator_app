import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/PostViewModel.dart';

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
    var provider = Provider.of<PostViewModel>(context, listen: false);
    provider.readPostFromLocal(widget.postId!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: provider.postLoading
              ? const Center(child: CircularProgressIndicator())
              : Text(provider.post == null ? "NA" : provider.post!.title!),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: provider.postLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Card(
                  color: Colors.yellow[100],
                  child:
                      Text(provider.post == null ? "NA" : provider.post!.body!),
                ),
              ),
      );
    });
  }
}
