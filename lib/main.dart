import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/circles_app.dart';
import 'package:karbarab/core/helper/bloc_delegate.dart';
import 'package:karbarab/utils/logger.dart';

void main() {
  configureLogger();
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(CirclesApp());
}
