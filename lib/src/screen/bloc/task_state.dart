part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}
class TaskError extends TaskState {}
class TaskSuccess extends TaskState {

  TaskSuccess({required this.task});
  final List<Map<String, dynamic>> task;

  @override
  List<Object> get props => [task];
}
class TaskLoading extends TaskState {}
