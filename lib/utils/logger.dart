import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:redux/redux.dart';
// import 'package:intl/intl.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Run this before starting app
void configureLogger() {
  if (!kReleaseMode) {
    // Add standard log output only on debug builds
    Logger.addClient(DebugLoggerClient());
  } else {
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
    Logger.addClient(CrashlyticsLoggerClient());
  }
}

void testsLogger() {
  Logger.addClient(DebugLoggerClient());
}

class Logger {
  static final _clients = <LoggerClient>[];

  /// Debug level logs
  static void d(
    String message, {
    dynamic e,
    StackTrace s,
  }) {
    _clients.forEach((c) => c.onLog(
          level: LogLevel.debug,
          message: message,
          e: e,
          s: s,
        ));
  }

  // Warning level logs
  static void w(
    String message, {
    dynamic e,
    StackTrace s,
  }) {
    _clients.forEach((c) => c.onLog(
      level: LogLevel.warning,
      message: message,
      e: e,
      s: s,
    ));
  }

  /// Error level logs
  /// Requires a current StackTrace to report correctly on Crashlytics
  /// Always reports as non-fatal to Crashlytics
  static void e(
    String message, {
    dynamic e,
    @required StackTrace s,
  }) {
    _clients.forEach((c) => c.onLog(
      level: LogLevel.error,
      message: message,
      e: e,
      s: s,
    ));
  }

  static void addClient(LoggerClient client) {
    _clients.add(client);
  }
}

/// Custom Middleware logger class
// class LoggerMiddleware<State> implements MiddlewareClass<State> {
//   @override
//   void call(Store<State> store, action, NextDispatcher next) {
//     next(action);

//     Logger.d('Middleware: { ${action.runtimeType} }');
//   }
// }

enum LogLevel { debug, warning, error }

abstract class LoggerClient {
  void onLog({
    LogLevel level,
    String message,
    dynamic e,
    StackTrace s,
  });
}

/// Debug logger that just prints to console
class DebugLoggerClient implements LoggerClient {

  String _timestamp() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute}:${now.second}.${now.millisecond}';
  }

  @override
  void onLog({
    LogLevel level,
    String message,
    dynamic e,
    StackTrace s,
  }) {
    switch (level) {
      case LogLevel.debug:
        debugPrint('${_timestamp()} [DEBUG]  $message');
        if (e != null) {
          debugPrint(e.toString());
          debugPrint(s.toString() ?? StackTrace.current);
        }
        break;
      case LogLevel.warning:
        debugPrint('${_timestamp()} [WARNING]  $message');
        if (e != null) {
          debugPrint(e.toString());
          debugPrint(s.toString() ?? StackTrace.current.toString());
        }
        break;
      case LogLevel.error:
        debugPrint('${_timestamp()} [ERROR]  $message');
        if (e != null) {
          debugPrint(e.toString());
        }
        // Errors always show a StackTrace
        debugPrint(s.toString() ?? StackTrace.current.toString());
        break;
    }
  }
}

/// Logger that reports to Crashlytics/Firebase
class CrashlyticsLoggerClient implements LoggerClient {
  @override
  void onLog({
    LogLevel level,
    String message,
    dynamic e,
    StackTrace s,
  }) {
    final instance = Crashlytics.instance;
    switch (level) {
      case LogLevel.debug:
        instance.log('[DEBUG] $message');
        if (e != null) {
          instance.log(e.toString());
          instance.log(s ?? StackTrace.current.toString());
        }
        break;
      case LogLevel.warning:
        instance.log('[WARNING] $message');
        if (e != null) {
          instance.log(e.toString());
          instance.log(s ?? StackTrace.current.toString());
        }
        break;
      case LogLevel.error:
        instance.log('[ERROR] $message');
        // Always report a non-fatal for errors
        if (e != null) {
          instance.recordError(e, s);
        } else {
          instance.recordError(Exception(message), s);
        }
        break;
    }
  }
}
