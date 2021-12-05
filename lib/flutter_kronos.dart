import 'dart:async';

import 'package:flutter/services.dart';

/// Unlike the device clock, the time reported by Kronos is unaffected when the local time is changed while your app is running
class FlutterKronos {
  static const MethodChannel _channel = const MethodChannel('flutter_kronos');

  /// Accessing [getCurrentTimeMs] will return the local time based on the last known accurate time + delta since last sync.
  static Future<int?> get getCurrentTimeMs async {
    return await _channel.invokeMethod("GET_CURRENT_TIME_MS");
  }

  /// If the NTP server cannot be reached or Kronos has not yet been synced,
  /// getCurrentTimeMs() will return time from the fallback clock and trigger syncInBackground().
  /// If you'd rather control the fallback, you can use getCurrentNtpTimeMs(),
  /// which returns null instead of falling back.  To get metadata with an individual timestamp,
  /// use KronosClock.getCurrentTime(), which returns an instance of KronosTime.
  /// KronosTime contains the currentTime and the timeSinceLastNtpSyncMs,
  /// which will be null if currentTime is coming from the device clock.
  static Future<int?> get getCurrentNtpTimeMs async {
    return await _channel.invokeMethod("GET_CURRENT_NTP_TIME_MS");
  }

  static void sync() {
    _channel.invokeMethod("SYNC");
  }
}
