import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/core/ui/popup.dart';

void checkConnectionFirst(Function callback, BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        getLogger('InternetService').w('internet ada');
        callback();
      }
    } on SocketException catch (_) {
      getLogger('InternetService').e('ga ada internet');
      popup(
        context,
        text: 'Internet kamu mati ya?',
        cancel: () {
          Navigator.of(context).pop();
        },
        confirm: () async {
          // ACTION_LOCATION_SOURCE_SETTINGS
          if (Platform.isAndroid) {
            const AndroidIntent intent = AndroidIntent(
              action: 'android.settings.WIFI_SETTINGS',
            );
            await intent.launch();
          } else {
            Navigator.of(context).pop();
          }
        },
        cancelAble: true,
        cancelLabel: 'Kembali',
        confirmLabel: 'Hidupkan',
      );
    } catch (e) {
      getLogger('InternetService').e('another catch');
    }
  }