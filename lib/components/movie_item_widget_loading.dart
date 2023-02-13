import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:movie_app_bloc/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../apiResponse/movie_response.dart';
import '../generated/PColor.dart';
import '../generated/assets.dart';

class MovieItemLoading extends StatelessWidget {
  const MovieItemLoading({super.key});

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
              SizedBox(height: 5 * responsiveSize.height),
              Text.rich(
                TextSpan(
                  text: "",
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
