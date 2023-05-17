import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';

class AiringNowTvsPage extends StatefulWidget {
  @override
  _AiringNowTvsPageState createState() => _AiringNowTvsPageState();
}

class _AiringNowTvsPageState extends State<AiringNowTvsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AiringNowTvBloc>().add(FetchAiringNowTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Now Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringNowTvBloc, AiringNowTvState>(
          builder: (context, state) {
            if (state is AiringNowTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringNowTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is AiringNowTvFailure) {
              return Center(
                key: Key('error_message_tv'),
                child: Text(state.message),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
