import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:karbarab/features/login/view/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            HeroProfile(userRepository: userRepository),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: 60.0,
            margin: const EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: greenColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person_outline, color: whiteColor),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(HomeScreen.routeName);
                  },
                  icon: Icon(Icons.videogame_asset, color: whiteColor),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.stars, color: whiteColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroProfile extends StatelessWidget {
  final UserRepository userRepository;
  const HeroProfile({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
      color: greyColorLight,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.avatar,
                  ),
                  radius: 60,
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
                    BoldRegularText(text: '8000', dark: true),
                    RaisedButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          LoggedOut(),
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen(userRepository: userRepository);
                        }), ModalRoute.withName('/'));
                      },
                      color: secondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SmallerText(
                          text: 'Ganti Akun',
                          dark: true,
                        ),
                      ),
                      elevation: 5,
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
