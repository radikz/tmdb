part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvState extends Equatable {
  const RecommendationTvState();

  @override
  List<Object> get props => [];
}

class RecommendationTvInitial extends RecommendationTvState {}

class RecommendationTvEmpty extends RecommendationTvState {}

class RecommendationTvLoading extends RecommendationTvState {}

class RecommendationTvLoaded extends RecommendationTvState {
  final List<Tv> result;

  const RecommendationTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class RecommendationTvFailure extends RecommendationTvState {
  final String message;

  const RecommendationTvFailure(this.message);
}
