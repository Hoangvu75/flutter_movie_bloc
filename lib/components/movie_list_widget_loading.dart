import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_bloc/components/movie_item_widget_loading.dart';
import 'package:movie_app_bloc/utils/app_utils.dart';

import '../../../generated/assets.dart';
import '../generated/PColor.dart';

class MovieListWidgetLoading extends StatelessWidget {
  final String title;

  const MovieListWidgetLoading({
    super.key,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++) const MovieItemLoading(),
            ],
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
