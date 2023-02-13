import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:movie_app_bloc/bloc/homeScreen/poster/poster_bloc.dart';
import 'package:movie_app_bloc/bloc/homeScreen/poster/poster_state.dart';
import 'package:movie_app_bloc/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/homeScreen/movie/movie_bloc.dart';
import '../../bloc/homeScreen/movie/movie_event.dart';
import '../../bloc/homeScreen/movie/movie_state.dart';
import '../../bloc/homeScreen/poster/poster_event.dart';
import '../../bloc/scroll_controller/scroll_controller_bloc.dart';
import '../../bloc/scroll_controller/scroll_controller_event.dart';
import '../../bloc/scroll_controller/scroll_controller_state.dart';
import '../../components/movie_list_widget.dart';
import '../../components/movie_list_widget_loading.dart';
import '../../generated/PColor.dart';
import '../../generated/assets.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 450) {
        context.read<ScrollControllerBloc>().add(OutTopEvent());
      } else {
        context.read<ScrollControllerBloc>().add(OnTopEvent());
      }
    });
    context.read<PosterBloc>().add(LoadPosterEvent());
    context.read<MovieBloc>().add(LoadMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              PColors.backgroundTop,
              PColors.backgroundBottom,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 500 * responsiveSize.height,
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.75),
              leading: ScaleTap(
                onPressed: () {},
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30 * responsiveSize.width,
                ),
              ),
              leadingWidth: 70,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              pinned: true,
              snap: false,
              floating: false,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: BlocBuilder<PosterBloc, PosterState>(
                builder: (context, posterState) {
                  if (posterState is PosterLoadingState) {
                    return posterLoadingWidget();
                  } else if (posterState is PosterLoadedState) {
                    return posterLoadedWidget(posterState);
                  }
                  return posterLoadingWidget();
                },
              ),
              title: BlocBuilder<ScrollControllerBloc, ScrollControllerState>(
                builder: (context, scrollState) {
                  return Text(
                    scrollState.isOnTop ? "" : "Movie app Bloc",
                    style: TextStyle(
                        fontFamily: Assets.fontsSVNGilroySemiBold,
                        fontSize: 24 * responsiveSize.width
                    ),
                  ); // update UI <=== new
                },
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50 * responsiveSize.height,
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, movieState) {
                  if (movieState is MovieLoadingState) {
                    return _movieLoadingWidget();
                  } else if (movieState is MovieLoadedState) {
                    return _movieLoadedWidget(movieState);
                  }
                  return _movieLoadingWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget posterLoadingWidget() {
    return FlexibleSpaceBar(
      background: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 500 * responsiveSize.height,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget posterLoadedWidget(PosterLoadedState posterState) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 500 * responsiveSize.height,
              color: Colors.white,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: posterState.poster,
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10 * responsiveSize.width,
            right: 10 * responsiveSize.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Watch now!",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Assets.fontsSVNGilroySemiBold,
                    fontSize: 20 * responsiveSize.width,
                  ),
                ),
                SizedBox(
                  width: 10 * responsiveSize.width,
                ),
                ScaleTap(
                  onPressed: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8 * responsiveSize.width),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieLoadingWidget() {
    return Column(
      children: const [
        MovieListWidgetLoading(
          title: "Trending",
        ),
        MovieListWidgetLoading(
          title: "Upcoming",
        ),
        MovieListWidgetLoading(
          title: "Top rated",
        ),
        MovieListWidgetLoading(
          title: "Popular",
        ),
      ],
    );
  }

  Widget _movieLoadedWidget(MovieLoadedState movieState) {
    return Column(
      children: [
        MovieListWidget(
          movies: movieState.trendingMovies,
          title: "Trending",
        ),
        MovieListWidget(
          movies: movieState.upcomingMovies,
          title: "Upcoming",
        ),
        MovieListWidget(
          movies: movieState.topRatedMovies,
          title: "Top rated",
        ),
        MovieListWidget(
          movies: movieState.popularMovies,
          title: "Popular",
        ),
      ],
    );
  }
}
