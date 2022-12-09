import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/tv/tv_ota_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTheAirTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv-show';

  @override
  _OnTheAirTvShowPageState createState() => _OnTheAirTvShowPageState();
}

class _OnTheAirTvShowPageState extends State<OnTheAirTvShowPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvOtaBloc>().add(OnFetchOta());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvOtaBloc, BaseBlocState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is Error) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Not Found'),
              );
            }
          },
        ),
      ),
    );
  }
}
