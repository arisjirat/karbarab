import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';

class FeedbackForm extends StatefulWidget {
  final Function onBack;
  final Function onSubmit;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  FeedbackForm({
    this.onBack,
    this.onSubmit,
    this.isLoading,
    this.isSuccess,
    this.isFailure,
  });

  @override
  FeedbackFormState createState() {
    return FeedbackFormState();
  }
}

class FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerShouldBe = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isSuccess) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RegularText(
              text: 'Terimakasih ya, atas kontribusi memberikan koreksi',
              dark: true,
            ),
            RaisedButton(
              color: whiteColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: greenColor, width: 2)),
              onPressed: () {
                controllerShouldBe.clear();
                if (!widget.isLoading) {
                  widget.onBack();
                }
              },
              child: RegularText(
                text: 'Kembali',
                dark: true,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ]);
    }
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.isFailure
              ? SmallerText(
                  text: 'Terjadi kesalahan! mohon coba lagi nanti',
                )
              : const SizedBox(
                  width: 0,
                ),
          !widget.isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegularText(
                      text: 'Jawaban yang benar',
                      dark: true,
                    ),
                    TextFormField(
                      enableSuggestions: false,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      controller: controllerShouldBe,
                      cursorColor: greenColor,
                      decoration: InputDecoration(
                        labelText: 'yang benar adalah...',
                        fillColor: greenColor,
                        filled: false,
                        hasFloatingPlaceholder: false,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2, color: greenColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 1, color: greenColor),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Tolong di isi ya';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : const SpinKitRotatingPlain(color: greenColor),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  color: whiteColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: greenColor, width: 2)),
                  onPressed: () {
                    if (!widget.isLoading) {
                      widget.onBack();
                    }
                  },
                  child: RegularText(
                    text: 'Kembali',
                    dark: true,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  color: greenColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: () {
                    if (_formKey.currentState.validate() && !widget.isLoading) {
                      widget.onSubmit(controllerShouldBe.text);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RegularText(
                        text: 'Kirim',
                        dark: false,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.send,
                        color: whiteColor,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // ),
    );
  }
}
