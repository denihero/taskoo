part of 'task_crud_bloc.dart';

abstract class TaskCudEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskAddEvent extends TaskCudEvent{
  final String title;
  final String subtitle;

  TaskAddEvent({required this.title,required this.subtitle});
}
class TaskDeleteEvent extends TaskCudEvent{
  final int id;

  TaskDeleteEvent({required this.id});
}
class TaskUpdateEvent extends TaskCudEvent{
  final int id;
  final String title;
  final String subtitle;

  TaskUpdateEvent({required this.id,required this.title,required this.subtitle});
}
class TaskGetEvent extends TaskCudEvent{}