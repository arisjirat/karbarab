import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/popup.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/features/karbarab/view/karbarab.dart';
import 'package:karbarab/features/login/bloc/bloc.dart';
import 'package:karbarab/features/login/view/login_screen.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/utils/logger.dart';

class HeroProfile extends StatelessWidget {
  final UserRepository userRepository;
  const HeroProfile({Key key, @required this.userRepository}) : super(key: key);

  void _googleSync(ctx) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return BlocListener<LoginBloc, LoginState>(
              listener: (c, state) {
                if (state.isSuccess) {
                  BlocProvider.of<AuthBloc>(context).add(LoggedIn());
                  Navigator.of(context).pop();
                }
                if (state.isUserExist) {
                  BlocProvider.of<LoginBloc>(context).add(ClearGoogle());
                }
                if (state.isFailure) {
                  BlocProvider.of<LoginBloc>(context).add(ClearGoogle());
                }
              },
              child: AlertDialog(
                title: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                        image: AssetImage(
                          'assets/images/google_logo.png',
                        ),
                        height: 20.0,
                      ),
                      const SizedBox(width: 20),
                      BoldRegularText(
                        text: 'Akun Google',
                      )
                    ],
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  side: BorderSide(color: greenColor, width: 2),
                ),
                titlePadding: const EdgeInsets.only(top: 20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    state is LoginState && state.isLoading
                        ? const SpinKitDoubleBounce(color: greenColor)
                        : const SizedBox(width: 0),
                    state is LoginState && state.isFailure
                        ? Align(
                            alignment: Alignment.center,
                            child: RegularText(
                              color: redColor,
                              text: 'Gagal, coba periksa koneksi kamu',
                            ),
                          )
                        : const SizedBox(width: 0),
                    state is LoginState && state.isUserExist
                        ? Align(
                            alignment: Alignment.center,
                            child: RegularText(
                              color: redColor,
                              text: 'Gagal, google kamu sudah terdaftar',
                            ),
                          )
                        : const SizedBox(width: 0),
                    const SizedBox(height: 20),
                    state is LoginState && state.isLoading
                        ? const SizedBox(width: 0)
                        : Align(
                            alignment: Alignment.center,
                            child: RegularText(
                              text: 'Koneksikan! supaya kamu bisa login kembali',
                            ),
                          ),
                  ],
                ),
                actions: <Widget>[
                  state is LoginState && state.isLoading
                      ? const SpinKitDoubleBounce(color: greenColor)
                      : RaisedButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: greenColor, width: 2),
                          ),
                          color: whiteColor,
                          child: RegularText(
                            text: 'Jangan!',
                            color: greenColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                  state is LoginState && state.isLoading
                      ? const SizedBox(
                          width: 0,
                        )
                      : RaisedButton(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: RegularText(
                              text: state is LoginState && state.isUserExist
                                  ? 'Coba dengan akun lain'
                                  : 'Ya, sambungkan google',
                              dark: false),
                          color: greenColor,
                          onPressed: () {
                            if (state is LoginState && state.isFailure) {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(ClearGoogle());
                            }
                            BlocProvider.of<LoginBloc>(ctx).add(GoogleSync());
                          },
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

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
            Logger.w('Token old: ${state.tokenFCM}');
            return Row(
              children: <Widget>[
                state.avatar != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                          state.avatar,
                        ),
                        radius: 45,
                        backgroundColor: Colors.transparent,
                      )
                    : const CircleAvatar(
                        radius: 45,
                        backgroundColor: whiteColor,
                        backgroundImage:
                            AssetImage('assets/images/character.png'),
                      ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RegularText(text: state.displayName, dark: true),
                    BoldRegularText(
                        text: state.totalPoints.toString(), dark: true),
                    Row(
                      children: <Widget>[
                        state.isGoogleAuth
                            ? RaisedButton(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  popup(
                                    context,
                                    text: 'Yakin Keluar Akun kamu?',
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
                                color: whiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SmallerText(
                                    text: 'Keluar Akun',
                                    dark: true,
                                  ),
                                ),
                                elevation: 5,
                              )
                            : RaisedButton(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  _googleSync(context);
                                },
                                color: whiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: <Widget>[
                                      const Image(
                                        image: AssetImage(
                                          'assets/images/google_logo.png',
                                        ),
                                        height: 20.0,
                                      ),
                                      const SizedBox(width: 10),
                                      SmallerText(
                                        text: 'Sambungkan',
                                        dark: true,
                                      )
                                    ],
                                  ),
                                ),
                                elevation: 5,
                              ),
                        const SizedBox(
                          width: 15,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(KarbarabScreen.routeName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SmallerText(
                              text: 'v0.0.1',
                              dark: true,
                            ),
                          ),
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
