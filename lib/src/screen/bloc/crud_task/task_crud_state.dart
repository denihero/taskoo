part of 'task_crud_bloc.dart';

abstract class TaskCrudState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskCrudInitial extends TaskCrudState {}

class TaskCrudError extends TaskCrudState {}

class TaskCrudSuccess extends TaskCrudState {
  TaskCrudSuccess({required this.tasks});
  final List<Map<String, dynamic>> tasks;

  @override
  List<Object> get props => [tasks];
}

class TaskSearchSuccess extends TaskCrudState {
  TaskSearchSuccess({required this.tasks});
  final Iterable<Map<String, dynamic>> tasks;

  @override
  List<Object> get props => [tasks];
}

class TaskCrudLoading extends TaskCrudState {}

class TaskCRUDFinish extends TaskCrudState {}
