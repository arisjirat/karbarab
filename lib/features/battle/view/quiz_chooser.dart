import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/cards/card_item.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/quiz/bloc/quiz_bloc.dart';
import 'package:karbarab/model/quiz.dart';

class QuizChooser extends StatefulWidget {
  final Function(Quiz) onSelect;
  QuizChooser({
    Key key,
    @required this.onSelect,
  }) : super(key: key);

  @override
  _QuizChooserState createState() => _QuizChooserState();
}

class _QuizChooserState extends State<QuizChooser> {
  TextEditingController search = TextEditingController();
  List<Quiz> filtered = [];

  @override
  void initState() {
    BlocProvider.of<QuizBloc>(context).add(GetAllGoodQuiz());
    super.initState();
  }

  void filtering(List<Quiz> list, value) {
    final RegExp reg = RegExp('${value.toLowerCase()}');
    setState(() {
      filtered =
          list.where((q) => reg.hasMatch(q.bahasa.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext _) {
    return BlocListener<QuizBloc, QuizState>(
      listener: (_, state) {
        if (state is AllGoodQuiz) {
          setState(() {
            state.list.shuffle();
            filtered = state.list;
          });
        }
      },
      child: BlocBuilder<QuizBloc, QuizState>(
        builder: (_, state) {
          if (state is AllGoodQuiz) {
            return Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 20,
                    right: 20,
                  ),
                  height: 0.14 * MediaQuery.of(_).size.height,
                  color: greenColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      MaterialButton(
                        padding: const EdgeInsets.all(10),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        minWidth: 0,
                        color: redColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          inputFormatters: [
                            WhitelistingTextInputFormatter(
                                RegExp('[a-zA-Z0-9\s]')),
                          ],
                          enableSuggestions: false,
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          controller: search,
                          style: TextStyle(color: whiteColor),
                          cursorColor: whiteColor,
                          onChanged: (v) {
                            if (!state.isLoading) {
                              filtering(state.list, v);
                            }
                          },
                          onEditingComplete: () {
                            if (!state.isLoading) {
                              filtering(state.list, search.text);
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 75, 20),
                            labelText: 'Cari Kartu Terbaik Kamu',
                            labelStyle: TextStyle(
                              color: whiteColor,
                            ),
                            errorStyle: TextStyle(color: whiteColor),
                            focusColor: whiteColor,
                            fillColor: greenColor,
                            hasFloatingPlaceholder: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(width: 2, color: whiteColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(width: 2, color: whiteColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(width: 2, color: whiteColor),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(width: 2, color: whiteColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(width: 2, color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                state.isLoading
                    ? const SpinKitDoubleBounce(
                        color: greenColor,
                      )
                    : const SizedBox(
                        width: 0,
                      ),
                state.isSuccess && state.list.isNotEmpty && filtered.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (_, id) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CardItemAction(
                                quiz: filtered[id],
                                onTap: (Quiz quiz) {
                                  widget.onSelect(quiz);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          itemCount: filtered.length,
                        ),
                      )
                    : const SizedBox(width: 0),
                filtered.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(100),
                        child: RegularText(
                          text: 'Kartu tidak ditemukan',
                        ),
                      )
                    : const SizedBox(width: 0),
                const SizedBox(height: 30),
                state.isSuccess && state.list.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(100),
                        child: RegularText(
                          text:
                              'Tidak ada kartu yang bisa dikirim, kamu harus punya kartu di yang nilai nya baik yaitu di atas 9',
                        ),
                      )
                    : const SizedBox(width: 0),
                const SizedBox(height: 30),
              ],
            );
          }
          return const SpinKitDoubleBounce(
            color: greenColor,
          );
        },
      ),
    );
  }
}
