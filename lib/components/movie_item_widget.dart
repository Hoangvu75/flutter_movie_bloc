import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:movie_app_bloc/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../apiResponse/movie_response.dart';
import '../generated/PColor.dart';
import '../generated/assets.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 * responsiveSize.width),
        child: SizedBox(
          width: 150,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 200,
                        width: 150,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      height: 200,
                      width: 150,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5 * responsiveSize.height),
              Text.rich(
                TextSpan(
                  text: movie.title == null ? movie.name.toString() : movie.title.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15 * responsiveSize.width,
                    color: PColors.defaultText,
                    fontFamily: Assets.fontsSVNGilroyRegular,
                  ),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
