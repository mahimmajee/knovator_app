import 'package:hive/hive.dart';
part 'TimerItem.g.dart';

@HiveType(typeId: 1)
class TimerItem {
  @HiveField(0)
  int? duration;

  @HiveField(1)
  bool? isPaused;

  TimerItem({this.duration, this.isPaused = true});
}
