import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/tv/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:tv/presentation/tv/provider/top_rated_tvs_notifier.dart';

class TopRatedTvsPage extends StatefulWidget {
  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedTvBloc>().add(FetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedTvFailure) {
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
