import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/battle/view/send_battle_card.dart';
import 'package:karbarab/features/battle_list/view/battle_list_view.dart';
import 'package:karbarab/features/home/view/home_screen.dart';

class BattleScreen extends StatefulWidget {
  static const String routeName = '/battle';
  const BattleScreen({Key key}) : super(key: key);

  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen>
    with TickerProviderStateMixin {
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColorLight,
      body: Stack(
        children: <Widget>[
          Container(
            height: 0.2 * deviceHeight(context),
            padding: const EdgeInsets.only(top: 35, left: 20, right: 20, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LogoTextSmaller(text: 'Kirim Kartu'.toUpperCase(), dark: true, color: greenColor,),
                const SizedBox(height: 10),
                SmallerText(text: 'Kirim kartu terbaikmu ke lawan. raih score 50 jika lawan menjawab tanpa salah, score 200 jika lawan gagal menjawab dengan sempurna, sebalik nya untuk penerima kartu', dark: true,)
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 0.2 * deviceHeight(context)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 0.8 * deviceHeight(context),
                      margin: const EdgeInsets.only(top: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[BattleListView(), SendBattleCard()],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                margin: EdgeInsets.only(
                  top: 0.25 * deviceHeight(context) - 20,
                  left: 90,
                  right: 90,
                ),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(width: 2.0, color: greenColor)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  child: TabBar(
                    unselectedLabelColor: whiteColor,
                    indicatorPadding: const EdgeInsets.all(20),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: secondaryColor,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: greenColor,
                    ),
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(
                          Icons.local_play,
                          color: _tabController.index == 0 ? whiteColor : greenColor,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.flash_on,
                          color: _tabController.index == 1 ? whiteColor : greenColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0.25 * deviceHeight(context) - 25,
                left: 15,
                child: MaterialButton(
                  padding: const EdgeInsets.all(10),
                  minWidth: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  color: secondaryColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed(HomeScreen.routeName);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
