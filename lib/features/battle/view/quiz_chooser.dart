import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/quiz/bloc/quiz_bloc.dart';

class QuizChooser extends StatefulWidget {
  QuizChooser({Key key}) : super(key: key);

  @override
  _QuizChooserState createState() => _QuizChooserState();
}

class _QuizChooserState extends State<QuizChooser> {
  @override
  void initState() {
    BlocProvider.of<QuizBloc>(context).add(GetAllQuiz());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              getLogger('Quiz').e(state);
              return RegularText(text: 'text');
            },
          ),
        ],
      ),
      //  child: child,
    );
  }
}
