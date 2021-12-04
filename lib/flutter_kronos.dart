import 'dart:async';

import 'package:flutter/services.dart';

class FlutterKronos {
  static const MethodChannel _channel = const MethodChannel('flutter_kronos');

  static Future<int?> get getCurrentTimeMs async {
    return await _channel.invokeMethod("GET_CURRENT_TIME_MS");
  }

  static Future<int?> get getCurrentNtpTimeMs async {
    return await _channel.invokeMethod("GET_CURRENT_NTP_TIME_MS");
  }

  static void sync() {
    _channel.invokeMethod("SYNC");
  }
}
