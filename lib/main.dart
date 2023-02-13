import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_bloc/screens/homeScreen/home_screen.dart';
import 'package:movie_app_bloc/screens/searchScreen/search_screen.dart';
import 'package:movie_app_bloc/splash.dart';
import 'package:movie_app_bloc/utils/app_utils.dart';

import 'generated/PColor.dart';
import 'generated/assets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainScreen(),
      },
      builder: _builder(),
    );
  }

  Widget Function(BuildContext, Widget?) _builder({Widget Function(BuildContext, Widget?)? builder}) {
    var newBuilder = EasyLoading.init(builder: builder);

    return (BuildContext context, Widget? child) {
      final mChild = child;
      if (mChild != null) {
        final widgetSize = MediaQuery.of(context).size;

        final mResponsiveWidth = widgetSize.width / 375; // 375: Design width
        final mResponsiveHeight = widgetSize.height / 812; // 812: Design height
        final mResponsiveSize = Size(mResponsiveWidth, mResponsiveHeight);

        if (mResponsiveWidth != responsiveSize.width || mResponsiveHeight != responsiveSize.height) {
          if (widgetSize.width > 650) {
            // AppUtils.isSuperBigPhone = true;
          }

          if (mResponsiveWidth > 1.2) {
            responsiveSize = Size(1.2, mResponsiveHeight);
          } else {
            responsiveSize = mResponsiveSize;
          }

          if (kDebugMode) {
            print(
                "widgetSize width: ${widgetSize.width}\nwidgetSize height: ${widgetSize.height}\nresponsiveSize: "
                    "$responsiveSize\nmResponsiveHeight: $mResponsiveHeight");
          }
        }

        return newBuilder(
          context,
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: mChild,
          ),
        );
      }

      return Container();
    };
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          const HomeScreen(),
          const SearchScreen(),
          Container(),
          Container(),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 50 * responsiveSize.width,
        height: 50 * responsiveSize.height,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: PColors.blueMain,
          onPressed: () {},
          child: SvgPicture.asset(
            width: 35 * responsiveSize.width,
            height: 35 * responsiveSize.height,
            color: Colors.white,
            Assets.svgsWebview,
          ), //icon inside button
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: PColors.backgroundBottom,
        shape: const CircularNotchedRectangle(),
        notchMargin: 7 * responsiveSize.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.movie_outlined, color: _currentIndex == 0 ? PColors.lightOrange : PColors.blueMain),
                    Text(
                      "Movies",
                      style: TextStyle(
                        color: _currentIndex == 0 ? PColors.lightOrange : PColors.blueMain,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 10 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search, color: _currentIndex == 1 ? PColors.lightOrange : PColors.blueMain),
                    Text(
                      "Search",
                      style: TextStyle(
                        color: _currentIndex == 1 ? PColors.lightOrange : PColors.blueMain,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 10 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.recommend_outlined,
                        color: _currentIndex == 2 ? PColors.lightOrange : PColors.blueMain),
                    Text(
                      "Suggest",
                      style: TextStyle(
                        color: _currentIndex == 2 ? PColors.lightOrange : PColors.blueMain,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 10 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle_outlined,
                        color: _currentIndex == 3 ? PColors.lightOrange : PColors.blueMain),
                    Text(
                      "Account",
                      style: TextStyle(
                        color: _currentIndex == 3 ? PColors.lightOrange : PColors.blueMain,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                        fontSize: 10 * responsiveSize.width,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
