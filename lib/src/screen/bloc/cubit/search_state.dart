part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchError extends SearchState {}
class SearchEmpty extends SearchState {}

class SearchLoaded extends SearchState {
  SearchLoaded({required this.tasks});
  final List<Map<String, dynamic>> tasks;

  @override
  List<Object> get props => [tasks];
}

class SearchLoading extends SearchState {}
