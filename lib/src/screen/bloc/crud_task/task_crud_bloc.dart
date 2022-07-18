import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskoo/service/database/sql_crud.dart';

part 'task_crud_event.dart';
part 'task_crud_state.dart';

class TaskCrudBloc extends Bloc<TaskCrudEvent, TaskCrudState> {
  TaskCrudBloc() : super(TaskCrudInitial()) {

    on<TaskGetEvent>((event,emit) async{
      emit(TaskCrudLoading());
      try{
        final getTask = await DatabaseCRUD.getItems();
        emit(TaskCrudSuccess(tasks: getTask));
      }catch(err,s){
        print(err);
        print(s);
        emit(TaskCrudError());
      }
    });

    on<TaskSearchEvent>((event,emit) async{
      emit(TaskCrudLoading());
      try{
        final searchTask = await DatabaseCRUD.searchTask();
        emit(TaskSearchSuccess(tasks: searchTask));
      }catch(err,s){
        print(err);
        print(s);
        emit(TaskCrudError());
      }
    });

    on<TaskAddEvent>((event,emit) async {
      try{
        await DatabaseCRUD.insertTask(event.title, event.subtitle);
        emit(TaskCRUDFinish());
      }catch(err,dtl){
        print(err);
        print(dtl);
        emit(TaskCrudError());
      }
    });

    on<TaskUpdateEvent>((event,emit) async {
      try{
       await DatabaseCRUD.updateItem(event.id,event.title,event.subtitle);
       emit(TaskCRUDFinish());
      }catch(err,dtl){
        print(err);
        print(dtl);
        emit(TaskCrudError());
      }
    });

    on<TaskDeleteEvent>((event,emit) async {
      try{
        await DatabaseCRUD.deleteItem(event.id);
        emit(TaskCRUDFinish());
      }catch(err,dtl){
        emit(TaskCrudError());
      }
    });
  }

}
