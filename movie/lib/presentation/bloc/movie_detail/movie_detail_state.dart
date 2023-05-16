part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail result;

  const MovieDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieDetailFailure extends MovieDetailState {
  final String message;

  const MovieDetailFailure(this.message);
}
