import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/tv/provider/airing_now_tvs_notifier.dart';

class AiringNowTvsPage extends StatefulWidget {
  @override
  _AiringNowTvsPageState createState() => _AiringNowTvsPageState();
}

class _AiringNowTvsPageState extends State<AiringNowTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AiringNowTvsNotifier>(context, listen: false)
            .fetchAiringNowTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Now Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringNowTvsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: Key('error_message_tv'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
