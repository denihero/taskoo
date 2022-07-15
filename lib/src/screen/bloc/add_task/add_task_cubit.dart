import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskoo/service/database/sql_crud.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  addTask(String title,String? subtitle) async{
    emit(AddTaskLoading());
    try{
      final result = await DatabaseCRUD.insertTask(title, subtitle);
      emit(AddTaskSuccess(result: result));
    }catch(err,dtl){
      print(err);
      print(dtl);
      emit(AddTaskError());
    }
  }

  deleteTask(int id) async{
    emit(AddTaskLoading());
    try{
      final result = await DatabaseCRUD.deleteItem(id);
      emit(AddTaskSuccess(result: result));
    }catch(err,dtl){
      print(err);
      print(dtl);
      emit(AddTaskError());
    }
  }

  updateTask(int id,String title,String subtitle) async{
    emit(AddTaskLoading());
    try{
      final result = await DatabaseCRUD.updateItem(id, title, subtitle);
      emit(AddTaskSuccess(result: result));
    }catch(err,dtl){
      print(err);
      print(dtl);
      emit(AddTaskError());
    }
  }
}
