part of 'task_crud_bloc.dart';

abstract class TaskCrudEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskAddEvent extends TaskCrudEvent{
  final String title;
  final String subtitle;

  TaskAddEvent({required this.title,required this.subtitle});
}
class TaskDeleteEvent extends TaskCrudEvent{
  final int id;

  TaskDeleteEvent({required this.id});
}
class TaskUpdateEvent extends TaskCrudEvent{
  final int id;
  final String title;
  final String subtitle;

  TaskUpdateEvent({required this.id,required this.title,required this.subtitle});
}class TaskSearchEvent extends TaskCrudEvent{}
class TaskGetEvent extends TaskCrudEvent{}