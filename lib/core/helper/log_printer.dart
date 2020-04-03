// import 'package:logger/logger.dart';

// class _SimpleLogPrinter extends LogPrinter {
//   final String className;
//   _SimpleLogPrinter(this.className);  

//   @override
//   void log(Level level, message, error, StackTrace stackTrace) {
//     final color = PrettyPrinter.levelColors[level];
//     final emoji = PrettyPrinter.levelEmojis[level];
//     println(color('$emoji $className - $message'));
//   }
// }

// Logger getLogger(String className) {
//   return Logger(printer: _SimpleLogPrinter(className));
// }