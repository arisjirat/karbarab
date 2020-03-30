import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/login/view/login_screen.dart';

class LoginForm extends StatefulWidget {
  final Function loginHandler;
  final bool loading;
  final CredentialsMode mode;
  LoginForm({
    Key key,
    @required this.loginHandler,
    @required this.loading,
    @required this.mode,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FocusNode usernameFocusNode;
  FocusNode passwordFocusNode;

  AnimationController _animationController;
  Animation<int> _curvedAnimation;
  bool passwordState = false;

  @override
  void didUpdateWidget(LoginForm oldWidget) {
    if (oldWidget.mode != widget.mode) {
      usernameFocusNode = FocusNode();
      setState(() {
        passwordState = false;
      });
      controllerUsername.clear();
      controllerPassword.clear();
      _animationController.forward(from: 0,);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _prev() {
    _animationController.forward(from: 0);
    setState(() {
      passwordState = false;
    });
  }

  void _next() {
     if (!passwordState && controllerUsername.text.length >= 3) {
      passwordFocusNode = FocusNode();
      _animationController.reverse();
      setState(() {
        passwordState = true;
      });
      return;
    }
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      widget.loginHandler(
        controllerUsername.text,
        controllerPassword.text,
      );
    }
  }

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
    final String modeString = widget.mode == CredentialsMode.LOGIN ? 'Login' : 'Signup';
    return Container(
      height: 110,
      width: 300,
      child: Form(
        key: _formKey,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Transform.translate(
              offset: Offset(-_curvedAnimation.value.toDouble(), 0),
              child: TextFormField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[a-z0-9]')),
                ],
                focusNode: usernameFocusNode,
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
                  _next();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 75, 20),
                  labelText: '$modeString Username',
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
              child: TextFormField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[a-z0-9]')),
                ],
                focusNode: passwordFocusNode,
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
                  _next();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(75, 20, 75, 20),
                  labelText: '$modeString Password',
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
                    return 'Masukan password anda';
                  }
                  return null;
                },
              ),
            ),
            !widget.loading ? Positioned(
              right: 2,
              top: 2,
              child: MaterialButton(
                color: whiteColor,
                padding: const EdgeInsets.all(15.5),
                minWidth: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(Icons.arrow_forward, color: greenColor),
                onPressed: () {
                  _next();
                },
              ),
            ) : const SizedBox(width: 0),
            passwordState ? Positioned(
              left: 2,
              top: 2,
              child: MaterialButton(
                padding: const EdgeInsets.all(15.5),
                minWidth: 0,
                color: redColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(Icons.arrow_back, color: whiteColor),
                onPressed: () {
                  _prev();
                },
              ),
            ) : const SizedBox(width: 0),
          ],
        ),
      ),
    );
  }
}
