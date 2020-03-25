import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/features/auth/view/card_item.dart';
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
    return Container(
      margin: EdgeInsets.only(top: 0.25 * deviceHeight(context) - 20),
      height: 0.8 * deviceHeight(context) - 40,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
            margin: const EdgeInsets.symmetric(horizontal: 70),
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
                      Icons.mood_bad,
                      color:
                          _tabController.index == 0 ? whiteColor : greenColor,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.star_border,
                      color:
                          _tabController.index == 1 ? whiteColor : greenColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 0.8 * deviceHeight(context) - (40 + 60),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<ScoreBloc, ScoreState>(
              builder: (context, state) {
                if (state is SummaryUserScore) {
                  return TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: state.badQuiz.length,
                        itemBuilder: (context, position) {
                          return CardItem(
                            positive: false,
                            bahasa: state.badQuiz[position].quiz.bahasa,
                            id: state.badQuiz[position].quizId,
                            arab: state.badQuiz[position].quiz.arab,
                            voice: state.badQuiz[position].quiz.voice,
                            image: state.badQuiz[position].quiz.image,
                            totalScore: state.badQuiz[position].totalScore,
                            averageScore: state.badQuiz[position].averageScore,
                            gameMode: state.badQuiz[position].quizMode,
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: state.goodQuiz.length,
                        itemBuilder: (context, position) {
                          return CardItem(
                            positive: true,
                            bahasa: state.goodQuiz[position].quiz.bahasa,
                            id: state.goodQuiz[position].quizId,
                            arab: state.goodQuiz[position].quiz.arab,
                            voice: state.goodQuiz[position].quiz.voice,
                            image: state.goodQuiz[position].quiz.image,
                            totalScore: state.goodQuiz[position].totalScore,
                            averageScore: state.goodQuiz[position].averageScore,
                            gameMode: state.goodQuiz[position].quizMode,
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
    );
  }
}
