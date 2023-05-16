part of 'recommendation_movie_bloc.dart';

abstract class RecommendationMovieState extends Equatable {
  const RecommendationMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationMovieInitial extends RecommendationMovieState {}

class RecommendationMovieEmpty extends RecommendationMovieState {}

class RecommendationMovieLoading extends RecommendationMovieState {}

class RecommendationMovieLoaded extends RecommendationMovieState {
  final List<Movie> result;

  const RecommendationMovieLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class RecommendationMovieFailure extends RecommendationMovieState {
  final String message;

  const RecommendationMovieFailure(this.message);
}
