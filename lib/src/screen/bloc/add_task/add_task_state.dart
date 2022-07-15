part of 'add_task_cubit.dart';

abstract class AddTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTaskInitial extends AddTaskState {}
class AddTaskLoading extends AddTaskState {}
class AddTaskError extends AddTaskState {}
class AddTaskSuccess extends AddTaskState {

  AddTaskSuccess({required this.result});
  final Database result;

  @override
  List<Object> get props => [result];

}
