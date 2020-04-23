
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/core/config/colors.dart';

class LoginField extends StatefulWidget {
  final Function next;
  final bool dark;
  final bool loading;
  final int animation;
  LoginField(
      {Key key,
      @required this.next,
      this.dark = false,
      @required this.loading,
      @required this.animation})
      : super(key: key);

  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerUsername = TextEditingController();

  FocusNode usernameFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 110,
        width: 300,
        child: Form(
          key: _formKey,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Transform.translate(
                offset: Offset(-widget.animation.toDouble(), 0),
                child: TextFormField(
                  focusNode: usernameFocusNode,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp('[a-z0-9]')),
                  ],
                  enableSuggestions: false,
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  controller: controllerUsername,
                  style:
                      TextStyle(color: widget.dark ? greenColor : whiteColor),
                  cursorColor: widget.dark ? greenColor : whiteColor,
                  onChanged: (v) {
                    _formKey.currentState.validate();
                  },
                  onEditingComplete: () {
                    widget.next(controllerUsername.text);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 75, 20),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: widget.dark ? greenColor : whiteColor,
                    ),
                    errorStyle:
                        TextStyle(color: widget.dark ? greenColor : whiteColor),
                    focusColor: widget.dark ? greenColor : whiteColor,
                    fillColor: greenColor,
                    hasFloatingPlaceholder: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 2,
                          color: widget.dark ? greenColor : whiteColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 2,
                          color: widget.dark ? greenColor : whiteColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 2,
                          color: widget.dark ? greenColor : whiteColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 2,
                          color: widget.dark ? greenColor : whiteColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 2,
                          color: widget.dark ? greenColor : whiteColor),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Isi dengan username';
                    }
                    if (value.length < 3) {
                      return 'Minimal 3 Huruf';
                    }
                    return null;
                  },
                ),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: !widget.loading
                    ? MaterialButton(
                        color: widget.dark ? greenColor : whiteColor,
                        padding: const EdgeInsets.all(15.5),
                        minWidth: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.arrow_forward,
                            color: widget.dark ? whiteColor : greenColor),
                        onPressed: () {
                          widget.next(controllerUsername.text);
                        },
                      )
                    : SpinKitDoubleBounce(
                        color: widget.dark ? greenColor : whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
