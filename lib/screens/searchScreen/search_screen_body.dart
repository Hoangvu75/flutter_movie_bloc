import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/searchScreen/searchMovie/search_movie_bloc.dart';
import 'package:movie_app_bloc/bloc/searchScreen/searchMovie/search_movie_event.dart';
import 'package:movie_app_bloc/bloc/searchScreen/searchMovie/search_movie_state.dart';
import 'package:movie_app_bloc/components/search_movie_item_widget.dart';
import 'package:movie_app_bloc/utils/app_utils.dart';

import '../../bloc/scroll_controller/scroll_controller_bloc.dart';
import '../../bloc/scroll_controller/scroll_controller_event.dart';
import '../../bloc/scroll_controller/scroll_controller_state.dart';
import '../../generated/PColor.dart';
import '../../generated/assets.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        context.read<ScrollControllerBloc>().add(OutTopEvent());
      } else {
        context.read<ScrollControllerBloc>().add(OnTopEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: PColors.darkBlue,
      onRefresh: () async {},
      child: Container(
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
          slivers: <Widget>[
            BlocBuilder<ScrollControllerBloc, ScrollControllerState>(builder: (context, scrollState) {
              return SliverAppBar(
                leadingWidth: 70,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 100 * responsiveSize.height,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: !scrollState.isOnTop ? Colors.white : Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: !scrollState.isOnTop ? null : EdgeInsets.only(left: 20 * responsiveSize.width),
                  title: Text(
                    "Search for movies",
                    style: TextStyle(
                      color: PColors.darkBlue,
                      fontFamily: !scrollState.isOnTop ? Assets.fontsSVNGilroyBold : Assets.fontsSVNGilroyMedium,
                      fontSize: !scrollState.isOnTop ? 16 * responsiveSize.width : 24 * responsiveSize.width,
                    ),
                  ),
                  centerTitle: !scrollState.isOnTop ? true : false,
                ),
              );
            }),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 25 * responsiveSize.height,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(15 * responsiveSize.width, 0, 15 * responsiveSize.width, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10 * responsiveSize.width),
                ),
                child: TextField(
                    onSubmitted: (value) {
                      context.read<SearchMovieBloc>().add(LoadSearchMovieEvent(value));
                    },
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    )),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50 * responsiveSize.height,
              ),
            ),
            BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, movieState) {
                if (movieState is SearchMovieLoadingState) {
                  return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 175 * responsiveSize.height),
                          width: 50 * responsiveSize.width,
                          height: 50 * responsiveSize.height,
                          child: const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                } else if (movieState is SearchMovieLoadedState) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: movieState.searchMovies.length,
                      (BuildContext context, int index) {
                        return SearchMovieItemWidget(movie: movieState.searchMovies[index], key: ValueKey(index));
                      },
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100 * responsiveSize.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
