import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/service/database/sql_crud.dart';
import 'package:taskoo/service/model/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  getTasks() async{
    emit(TaskLoading());
    try{
      final result = await DatabaseCRUD.getItems();
      emit(TaskSuccess(task: result));
    }catch(err,s){
      print(err);
      print(s);
      emit(TaskError());
    }
  }


}
