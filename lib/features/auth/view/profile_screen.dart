import 'package:flutter/material.dart';

import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/auth/view/global_score.dart';
import 'package:karbarab/features/auth/view/hero_profile.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/features/home/view/home_screen.dart';


class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final UserRepository userRepository = UserRepository();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          HeroProfile(userRepository: userRepository),
          GlobalScore(),
        ],
      ),
      floatingActionButton: Transform.scale(
        scale: 1.4,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
          child: Icon(
            Icons.videogame_asset,
            color: textColor,
            size: 30,
          ),
          backgroundColor: secondaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigation(
        tabController: _tabController,
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final TabController tabController;
  const BottomNavigation({Key key, @required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColorLight,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: greenColorLight,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 55.0,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            margin: const EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: greenColor,
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: TabBar(
                  controller: tabController,
                  unselectedLabelColor: whiteColor,
                  indicatorPadding: const EdgeInsets.all(20),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: secondaryColor,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: secondaryColor.withOpacity(0.3),
                  ),
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(
                        Icons.person_outline,
                        size: 35,
                        color: tabController.index == 0
                            ? secondaryColor
                            : whiteColor,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.stars,
                        size: 35,
                        color: tabController.index == 1
                            ? secondaryColor
                            : whiteColor,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

