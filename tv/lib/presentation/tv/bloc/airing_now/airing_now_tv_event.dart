part of 'airing_now_tv_bloc.dart';

abstract class AiringNowTvEvent extends Equatable {
  const AiringNowTvEvent();

  @override
  List<Object> get props => [];
}

class FetchAiringNowTv extends AiringNowTvEvent {}
