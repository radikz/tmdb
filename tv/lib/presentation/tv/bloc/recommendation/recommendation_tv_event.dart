part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvEvent extends Equatable {
  const RecommendationTvEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationTv extends RecommendationTvEvent {
  final int id;

  const FetchRecommendationTv(this.id);

  @override
  List<Object> get props => [id];
}
