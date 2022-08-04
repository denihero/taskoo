import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/service/database/sql_crud.dart';

part 'task_crud_event.dart';
part 'task_crud_state.dart';

class TaskCrudBloc extends Bloc<TaskCrudEvent, TaskCrudState> {
  TaskCrudBloc() : super(TaskCrudInitial()) {
    on<TaskGetEvent>((event, emit) async {
      emit(TaskCrudLoading());
      try {
        final getTask = await DatabaseCRUD.getItems();
        emit(TaskCrudSuccess(tasks: getTask));
      } catch (err, s) {
        if (kDebugMode) {
          print(err);
          print(s);
        }

        emit(TaskCrudError());
      }
    });

    on<TaskAddEvent>((event, emit) async {
      try {
        await DatabaseCRUD.insertTask(event.title, event.subtitle);
        emit(TaskCRUDFinish());
      } catch (err, dtl) {
        if (kDebugMode) {
          print(err);
          print(dtl);
        }

        emit(TaskCrudError());
      }
    });

    on<TaskUpdateEvent>((event, emit) async {
      try {
        await DatabaseCRUD.updateItem(event.id, event.title, event.subtitle);
        emit(TaskCRUDFinish());
      } catch (err, dtl) {
        if (kDebugMode) {
          print(err);
          print(dtl);

        }
        emit(TaskCrudError());
      }
    });

    on<TaskDeleteEvent>((event, emit) async {
      try {
        await DatabaseCRUD.deleteItem(event.id);
        emit(TaskCRUDFinish());
      } catch (err) {
        emit(TaskCrudError());
      }
    });
  }
}
