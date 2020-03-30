import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karbarab/core/config/colors.dart';

class SignupForm extends StatefulWidget {
  final Function loginHandler;
  SignupForm({
    Key key,
    @required this.loginHandler,
  }) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  AnimationController _animationController;
  Animation<int> _curvedAnimation;

  bool passwordState = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutQuart);
    _curvedAnimation = IntTween(
      begin: 900,
      end: 0,
    ).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 200,
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(-_curvedAnimation.value.toDouble(), 0),
              child: TextFormField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[a-z0-9]')),
                ],
                enableSuggestions: false,
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                controller: controllerUsername,
                style: const TextStyle(color: whiteColor),
                cursorColor: whiteColor,
                onChanged: (v) {
                  _formKey.currentState.validate();
                },
                onEditingComplete: () {
                  _formKey.currentState.validate();
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(
                    color: whiteColor,
                  ),
                  errorStyle: const TextStyle(color: whiteColor),
                  focusColor: whiteColor,
                  fillColor: greenColor,
                  hasFloatingPlaceholder: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
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
            Transform.translate(
              offset: Offset(900 - _curvedAnimation.value.toDouble(), 0),
              // offset: Offset.fromDirection(20),
              child: TextFormField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[a-z0-9]')),
                ],
                obscureText: true,
                enableSuggestions: false,
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                controller: controllerPassword,
                style: const TextStyle(color: whiteColor),
                cursorColor: whiteColor,
                onChanged: (v) {
                  _formKey.currentState.validate();
                },
                onEditingComplete: () {
                  _formKey.currentState.validate();
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: whiteColor,
                  ),
                  errorStyle: const TextStyle(color: whiteColor),
                  focusColor: whiteColor,
                  fillColor: greenColor,
                  hasFloatingPlaceholder: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2, color: whiteColor),
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
              right: 1,
              top: 5,
              child: MaterialButton(
                padding: const EdgeInsets.all(10),
                minWidth: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  side: BorderSide(color: greenColor, width: 2),
                ),
                child: Icon(Icons.arrow_forward, color: whiteColor),
                onPressed: () {
                  if (passwordState) {
                    _animationController.forward(from: 0.0);
                  } else {
                    _animationController.reverse();
                  }
                  setState(() {
                    passwordState = !passwordState;
                  });
                  // if (_formKey.currentState.validate()) {}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
