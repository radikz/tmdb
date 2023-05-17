part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();
  
  @override
  List<Object> get props => [];
}

class TopRatedTvInitial extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<Tv> result;

  const TopRatedTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvFailure extends TopRatedTvState {
  final String message;

  const TopRatedTvFailure(this.message);
}