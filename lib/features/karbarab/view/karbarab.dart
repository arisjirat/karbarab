import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/device_height.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/auth/view/profile_screen.dart';

class KarbarabScreen extends StatelessWidget {
  static const String routeName = '/karbarab-about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  LogoText(
                    text: 'Karbarab',
                    dark: false,
                    // color: greenColor,
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/character.png'),
                        height: 90,
                      ),
                      const Positioned(
                        top: 30,
                        left: -15,
                        width: 100,
                        child: Image(
                          image: AssetImage('assets/images/card_logo.png'),
                          height: 110,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.65 * deviceHeight(context),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            child: Column(
                              children: [
                                RowContainer(
                                  label: 'Author',
                                  value: 'arisjiratkurniawan@gmail.com',
                                ),
                                RowContainer(
                                  label: 'Versi',
                                  value: 'v1.0.0+5',
                                ),
                                RowContainer(
                                  label: 'Credits',
                                  value: 'Aris Jirat Kurniawan',
                                ),
                                RowContainer(
                                  label: '',
                                  value: '-',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // SmallerText(
                        //   text: '@ 2020',
                        //   dark: true,
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ProfileScreen.routeName);
                          },
                          color: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmallerText(
                              text: 'Kembali',
                              dark: true,
                            ),
                          ),
                          elevation: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class RowContainer extends StatelessWidget {
  final String label;
  final String value;
  RowContainer({@required this.label, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: greyColor,
            width: (0.23 * MediaQuery.of(context).size.width) - 20,
            padding: const EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SmallerText(
                dark: false,
                text: '$label',
              ),
            ),
          ),
          Container(
            color: greyColorLight,
            width: (0.77 * MediaQuery.of(context).size.width) - 20,
            padding: const EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: BoldRegularText(
                text: value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
