import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/auth/view/card_score_item.dart';
import 'package:karbarab/features/users/bloc/users_bloc.dart';
import 'package:karbarab/model/user.dart';

class UserChooser extends StatefulWidget {
  final Function(User) onSelect;
  UserChooser({Key key, @required this.onSelect}) : super(key: key);

  @override
  _UserChooserState createState() => _UserChooserState();
}

class _UserChooserState extends State<UserChooser> {
  TextEditingController search = TextEditingController();
  List<User> filtered = [];

  @override
  void initState() {
    BlocProvider.of<UsersBloc>(context).add(GetUsers());
    super.initState();
  }

  void filtering(List<User> list, value) {
    final RegExp reg = RegExp('${value.toLowerCase()}');
    setState(() {
      filtered =
          list.where((q) => reg.hasMatch(q.username.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (_, state) {
        if (state is UsersState) {
          setState(() {
            state.users.shuffle();
            filtered = state.users;
          });
        }
      },
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (_, state) {
          if (state is UsersState) {
            return Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
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
                          // widget.onCancel();
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
                            WhitelistingTextInputFormatter(RegExp('[a-zA-Z0-9\s]')),
                          ],
                          enableSuggestions: false,
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          controller: search,
                          style: TextStyle(color: whiteColor),
                          cursorColor: whiteColor,
                          onChanged: (v) {
                            filtering(state.users, v);
                          },
                          onEditingComplete: () {
                            filtering(state.users, search.text);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(20, 20, 75, 20),
                            labelText: 'Cari Quiz',
                            labelStyle: TextStyle(
                              color: whiteColor,
                            ),
                            errorStyle: TextStyle(color: whiteColor),
                            focusColor: whiteColor,
                            fillColor: greenColor,
                            hasFloatingPlaceholder: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 2, color: whiteColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 2, color: whiteColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 2, color: whiteColor),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 2, color: whiteColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 2, color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, id) {
                      return CardUserAction(
                        users: filtered[id],
                        onTap: (User quiz) {
                          widget.onSelect(quiz);
                          Navigator.pop(context);
                        },
                        
                      );
                    },
                    itemCount: filtered.length,
                  ),
                ),
              ],
            );
          }
          return RegularText(text: 'text');
        },
      ),
    );
  }
}