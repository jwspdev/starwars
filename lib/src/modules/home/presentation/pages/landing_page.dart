// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:star_wars_app/src/core/utils/custom_colors.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/home_page.dart';
import 'package:star_wars_app/src/modules/liked/presentation/films/pages/rate_films_page.dart';
import 'package:star_wars_app/src/modules/liked/presentation/liked_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
  });
  static const String routePath = "/";
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  var titles = ["Star Wars", "Liked"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles.elementAt(_selectedIndex),
          style: starWarsFont(fontSize: 24, color: Colors.amber)
              .merge(customOutlinedTextStyle()),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      extendBody: true,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [HomePage(), LikedPage()],
      ),
      floatingActionButton: Visibility(
          visible: _selectedIndex == 1,
          child: FloatingActionButton.extended(
              label: Row(
                children: [
                  const Icon(
                    CupertinoIcons.film,
                    color: Colors.black,
                  ),
                  Text(
                    '  Rank Films',
                    style: openSansMedium(),
                  )
                ],
              ),
              onPressed: () {
                context.push(RateFilmsPage.routePath);
              })),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        height: kBottomNavigationBarHeight,
        color: CustomColors.primaryColor,
        notchMargin: 6,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 100,
              height: kBottomNavigationBarHeight,
              child: InkWell(
                child: Icon(
                  Icons.home,
                  color: _selectedIndex == 0 ? Colors.black : Colors.white,
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                    _pageController.jumpToPage(_selectedIndex);
                  });
                },
              ),
            ),
            SizedBox(
              width: 100,
              height: kBottomNavigationBarHeight,
              child: InkWell(
                child: Icon(
                  CupertinoIcons.heart_fill,
                  color: _selectedIndex == 1 ? Colors.black : Colors.white,
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                    _pageController.jumpToPage(_selectedIndex);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
