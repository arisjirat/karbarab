import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/users/bloc/users_bloc.dart';

class UserChooser extends StatefulWidget {
  UserChooser({Key key}) : super(key: key);

  @override
  _UserChooserState createState() => _UserChooserState();
}

class _UserChooserState extends State<UserChooser> {
  @override
  void initState() {
    BlocProvider.of<UsersBloc>(context).add(GetUsers());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              getLogger('Users').e(state);
              return RegularText(text: 'text');
            },
          ),
        ],
      )
      //  child: child,
    );
  }
}