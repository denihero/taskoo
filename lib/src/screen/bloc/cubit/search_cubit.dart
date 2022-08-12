import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/service/database/sql_crud.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void searchTask(String query) async{
    emit(SearchLoading());
    try{
      final listItems = await DatabaseCRUD.getItems();
      final result = listItems.where((element) => element.values.toString().toLowerCase().contains(query.toLowerCase())).toList();
      if(result.isNotEmpty){
        emit(SearchLoaded(tasks: result));
      }else{
        emit(SearchEmpty());
      }
    }catch(e){
      emit(SearchError());
    }
  }
}
