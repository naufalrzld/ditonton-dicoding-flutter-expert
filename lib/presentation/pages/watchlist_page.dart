import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watch_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watch_list_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-page';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieWatchListBloc>(context, listen: false)
          .add(OnFetchWatchListMovie());
      Provider.of<TvWatchListBloc>(context, listen: false)
          .add(OnFetchWatchListTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<MovieWatchListBloc>(context, listen: false)
        .add(OnFetchWatchListMovie());
    Provider.of<TvWatchListBloc>(context, listen: false)
        .add(OnFetchWatchListTv());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            tabs: [
              Tab(text: "Movies", icon: Icon(Icons.movie)),
              Tab(text: "TV Show", icon: Icon(Icons.live_tv)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<MovieWatchListBloc, BaseBlocState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.result[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.result.length,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<TvWatchListBloc, BaseBlocState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final tv = state.result[index];
                        return TvCard(tv);
                      },
                      itemCount: state.result.length,
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
