import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/popular/popular_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/top_rated/top_rated_tv_bloc.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<AiringNowTvBloc>().add(FetchAiringNowTv());
    context.read<PopularTvBloc>().add(FetchPopularTv());
    context.read<TopRatedTvBloc>().add(FetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton Tv'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchTvsRoute);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Airing Now',
                onTap: () => Navigator.pushNamed(context, airingTvsRoute),
              ),
              BlocBuilder<AiringNowTvBloc, AiringNowTvState>(
                builder: (context, state) {
                if (state is AiringNowTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AiringNowTvLoaded) {
                  return TvList(state.result);
                } else {
                  return Text('Failed');
                }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularTvsRoute),
              ),
              BlocBuilder<PopularTvBloc, PopularTvState>(
                builder: (context, state) {
                if (state is PopularTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvLoaded) {
                  return TvList(state.result);
                } else {
                  return Text('Failed');
                }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedTvsRoute),
              ),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
                if (state is TopRatedTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvLoaded) {
                  return TvList(state.result);
                } else {
                  return Text('Failed');
                }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> movies;

  TvList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvDetailRoute,
                  arguments: movie.id,
                );
                print('$BASE_IMAGE_URL${movie.posterPath}');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: AppNetworkImage(
                  imageUrl: '${movie.posterPath}',
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
