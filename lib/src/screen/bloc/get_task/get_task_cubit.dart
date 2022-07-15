import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/service/database/sql_crud.dart';

part 'get_task_state.dart';

class GetTaskCubit extends Cubit<GetTaskState> {
  GetTaskCubit() : super(GetTaskInitial());

  getTasks() async{
    emit(GetTaskLoading());
    try{
      final result = await DatabaseCRUD.getItems();
      emit(GetTaskSuccess(task: result));
    }catch(err,s){
      print(err);
      print(s);
      emit(GetTaskError());
    }
  }
}
