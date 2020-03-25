import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/popup.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/features/karbarab/view/karbarab.dart';
import 'package:karbarab/features/login/view/login_screen.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/core/config/colors.dart';

class HeroProfile extends StatelessWidget {
  final UserRepository userRepository;
  const HeroProfile({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.25 * deviceHeight(context),
      padding: const EdgeInsets.fromLTRB(10, 30, 0, 20),
      decoration: BoxDecoration(
        color: greyColorLight,
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.2),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: const Offset(
              2.0,
              5.0,
            ),
          )
        ],
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.avatar,
                  ),
                  radius: 45,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RegularText(text: state.fullname, dark: true),
                    BoldRegularText(
                        text: state.totalPoints.toString(), dark: true),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            popup(
                              context,
                              text: 'Yakin logout?',
                              cancel: () {
                                Navigator.of(context).pop();
                              },
                              confirm: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  LoggedOut(),
                                );
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) {
                                  return LoginScreen(
                                      userRepository: userRepository);
                                }), ModalRoute.withName('/'));
                              },
                              cancelAble: true,
                              cancelLabel: 'Jangan!',
                              confirmLabel: 'Ya, saya yakin',
                            );
                          },
                          color: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmallerText(
                              text: 'Keluar',
                              dark: true,
                            ),
                          ),
                          elevation: 5,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        RaisedButton(
                          color: whiteColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(KarbarabScreen.routeName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmallerText(
                              text: 'Karbarab v1.0.0',
                              dark: true,
                            ),
                          ),
                          elevation: 1,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            );
          }
          return Container(
            width: 0,
            height: 0,
          );
        },
      ),
    );
  }
}
