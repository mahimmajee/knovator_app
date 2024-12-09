abstract class PostEvent {
  @override
  List<Object> get props => [];
}

class PostsFetched extends PostEvent {}

class PostFetched extends PostEvent {
  final int postId;
  PostFetched({required this.postId});

  @override
  List<Object> get props => [postId];
}

class ChangeTileColor extends PostEvent {
  final int index;
  ChangeTileColor({required this.index});

  @override
  List<Object> get props => [index];
}

class ToggleTimer extends PostEvent {
  final int index;
  final bool isVisible;
  ToggleTimer({required this.index, required this.isVisible});

  @override
  List<Object> get props => [index, isVisible];
}

class UpdateTimer extends PostEvent {
  final int index;
  UpdateTimer({required this.index});

  @override
  List<Object> get props => [index];
}
