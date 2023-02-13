import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_bloc/utils/app_utils.dart';

import '../../../apiResponse/movie_response.dart';
import '../../../generated/assets.dart';
import '../generated/PColor.dart';
import 'movie_item_widget.dart';

class MovieListWidget extends StatelessWidget {
  final List<Movie> movies;
  final String title;

  const MovieListWidget({
    super.key,
    required this.movies,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10 * responsiveSize.width),
          child: Text(
            title,
            style: TextStyle(
                color: PColors.defaultText,
                fontSize: 20 * responsiveSize.height,
                fontFamily: Assets.fontsSVNGilroyBold),
          ),
        ),
        SizedBox(height: 15 * responsiveSize.height),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: (movies.length >= 5)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [for (int i = 0; i < 5; i++) MovieItem(movie: movies[i])],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [for (int i = 0; i < movies.length; i++) MovieItem(movie: movies[i])],
                ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ScaleTap(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "View more",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15 * responsiveSize.width,
                        color: PColors.darkBlue,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(width: 10 * responsiveSize.width),
                  SvgPicture.asset(Assets.svgsIcUnion)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
