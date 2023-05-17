part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();
  
  @override
  List<Object> get props => [];
}

class PopularTvInitial extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<Tv> result;

  const PopularTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class PopularTvFailure extends PopularTvState {
  final String message;

  const PopularTvFailure(this.message);
}