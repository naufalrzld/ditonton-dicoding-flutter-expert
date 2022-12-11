import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/data/datasources/api_services.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watch_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_ota_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watch_list_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_show/home_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tv_show/on_the_air_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tv_show/popular_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tv_show/search_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tv_show/top_rated_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tv_show/tv_show_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.initClient();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchListBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvOtaBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchListBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTVShowPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTVShowPage());
            case OnTheAirTvShowPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnTheAirTvShowPage());
            case PopularTvShowPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvShowPage());
            case TopRatedTvShowPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowPage());
            case TvShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchTvShowPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvShowPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
