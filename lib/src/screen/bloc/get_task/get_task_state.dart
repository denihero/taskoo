part of 'get_task_cubit.dart';

abstract class GetTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTaskInitial extends GetTaskState {}
class GetTaskError extends GetTaskState {}
class GetTaskSuccess extends GetTaskState {
  GetTaskSuccess({required this.task});
  final List<Map<String, dynamic>> task;

  @override
  List<Object> get props => [task];
}
class GetTaskLoading extends GetTaskState {}
