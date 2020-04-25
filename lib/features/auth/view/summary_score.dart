import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/cards/card_item.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';

class SummaryScore extends StatefulWidget {
  const SummaryScore({Key key}) : super(key: key);

  @override
  _SummaryScoreState createState() => _SummaryScoreState();
}

class _SummaryScoreState extends State<SummaryScore>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ScoreBloc>(context).add(GetSummaryUserQuizScore());
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
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 0.25 * deviceHeight(context) - 20),
          height: 0.8 * deviceHeight(context),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 0.8 * deviceHeight(context) - (40 + 40),
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: BlocBuilder<ScoreBloc, ScoreState>(
                  builder: (context, state) {
                    if (state is SummaryUserScore) {
                      return TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          state.goodQuiz.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SmallerText(
                                      dark: true,
                                      text: 'Belum ada quiz terbaik untuk kamu',
                                    ),
                                    SmallerText(
                                      dark: true,
                                      text: 'Nilai rata rata kartu di atas 75',
                                    ),
                                    RaisedButton(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(HomeScreen.routeName);
                                      },
                                      color: secondaryColor,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SmallerText(
                                              text: 'Main',
                                              dark: true,
                                            ),
                                          ),
                                          Icon(Icons.videogame_asset,
                                              color: textColor),
                                        ],
                                      ),
                                      elevation: 5,
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: state.goodQuiz.length,
                                  itemBuilder: (context, position) {
                                    return CardItem(
                                      key: Key(state.goodQuiz[position].quizId),
                                      positive: true,
                                      quiz: state.goodQuiz[position].quiz,
                                      totalScore:
                                          state.goodQuiz[position].totalScore,
                                      averageScore:
                                          state.goodQuiz[position].averageScore,
                                      gameMode:
                                          state.goodQuiz[position].quizMode,
                                    );
                                  },
                                ),
                          state.badQuiz.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SmallerText(
                                      dark: true,
                                      text:
                                          'Belum ada quiz yang buruk untuk kamu',
                                    ),
                                    SmallerText(
                                      dark: true,
                                      text: 'Nilai rata rata kartu 75 ke bawah',
                                    ),
                                    RaisedButton(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(HomeScreen.routeName);
                                      },
                                      color: secondaryColor,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SmallerText(
                                              text: 'Main',
                                              dark: true,
                                            ),
                                          ),
                                          Icon(Icons.videogame_asset,
                                              color: textColor),
                                        ],
                                      ),
                                      elevation: 5,
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: state.badQuiz.length,
                                  itemBuilder: (context, position) {
                                    return CardItem(
                                      key: Key(state.badQuiz[position].quizId),
                                      positive: false,
                                      quiz: state.badQuiz[position].quiz,
                                      totalScore:
                                          state.badQuiz[position].totalScore,
                                      averageScore:
                                          state.badQuiz[position].averageScore,
                                      gameMode:
                                          state.badQuiz[position].quizMode,
                                    );
                                  },
                                ),
                        ],
                      );
                    }
                    return const SpinKitRotatingPlain(color: greenColor);
                  },
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
                    Icons.star_border,
                    color: _tabController.index == 0 ? whiteColor : greenColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.mood_bad,
                    color: _tabController.index == 1 ? whiteColor : greenColor,
                  ),
                ),
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
    );
  }
}
