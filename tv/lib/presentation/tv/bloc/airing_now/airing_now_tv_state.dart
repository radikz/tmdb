part of 'airing_now_tv_bloc.dart';

abstract class AiringNowTvState extends Equatable {
  const AiringNowTvState();
  
  @override
  List<Object> get props => [];
}

class AiringNowTvInitial extends AiringNowTvState {}

class AiringNowTvLoading extends AiringNowTvState {}

class AiringNowTvLoaded extends AiringNowTvState {
  final List<Tv> result;

  const AiringNowTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class AiringNowTvFailure extends AiringNowTvState {
  final String message;

  const AiringNowTvFailure(this.message);
}