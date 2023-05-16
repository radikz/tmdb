part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> result;

  const PopularMovieLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class PopularMovieFailure extends PopularMovieState {
  final String message;

  const PopularMovieFailure(this.message);
}
