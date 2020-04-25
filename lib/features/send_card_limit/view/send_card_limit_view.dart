import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/features/admob/bloc/admob_bloc.dart';
import 'package:karbarab/features/admob/view/ads.dart';
import 'package:karbarab/features/send_card_limit/bloc/send_card_limit_bloc.dart';

class SendCardLimitView extends StatefulWidget {
  SendCardLimitView({Key key}) : super(key: key);

  @override
  _SendCardLimitViewState createState() => _SendCardLimitViewState();
}

class _SendCardLimitViewState extends State<SendCardLimitView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SendCardLimitBloc>(context).add(GetSendCardLimit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendCardLimitBloc, SendCardLimitState>(
      builder: (context, state) {
        if (state is HasSendCardLimit) {
          return Column(
            children: <Widget>[
              state.isLoading
                  ? const SpinKitThreeBounce(
                      color: greenColor,
                    )
                  : state.limit < 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RegularText(
                              text: 'Kesempatan kirim kartu habis',
                            ),
                            RegularText(
                              text: 'isi lagi yuk dengan tonton iklan',
                            ),
                            const SizedBox(height: 20),
                            AdsScreen(
                              adsMode: AdsMode.HINT,
                              onReward: () {
                                BlocProvider.of<SendCardLimitBloc>(context)
                                    .add(AddSendCardLimit());
                              },
                              buttonShow: Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: greenColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: textColor.withOpacity(0.5),
                                      offset: const Offset(0.0, 0.0),
                                    ),
                                    BoxShadow(
                                      color: textColor.withOpacity(0.5),
                                      offset: const Offset(0.0, 0.1),
                                      spreadRadius: -2.0,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      : RegularText(
                          text:
                              'Tersisa ${state.limit.toString()}x kesempatan mengirim',
                        )
            ],
          );
        }
        return const SizedBox(
          width: 0,
        );
      },
    );
  }
}
