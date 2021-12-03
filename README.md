# Kronos - NTP plugin for Flutter


Unlike the device clock, the time reported by Kronos is unaffected when the local time is changed while your app is running. Instead, Kronos stores accurate time along with a delta between the NTP time and the system uptime. Since uptime increases monotonically, Kronos isn't affected by device time changes. Accessing KronosClock.getCurrentTimeMs() will return the local time based on the last known accurate time + delta since last sync.


This plugin is based on [`Kronos`][1] in iOS and [`Kronos-Android`][2] in android for the whole SNTP protocol implementation.

## Installation

Just add `flutter_kronos` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

### Android

Add the following permission in your Android Manifest file:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Usage

### Sync clock using a pool of NTP servers

Calling `Clock.sync` will fire a bunch of NTP requests to up to 5 of the
servers on the given NTP pool. As soon as
we get the first response, the given closure is called but the `Clock`
will keep trying to get a more accurate response.

```dart
KronosClock.sync();
```

### Get an NTP time
```dart
KronosClock.getCurrentTimeMs(); //return time from the fallback clock if Kronos has not yet been synced
KronosClock.getCurrentNtpTimeMs(); //return null if Kronos has not yet been synced
```


[1]: https://github.com/lyft/Kronos
[2]: https://github.com/lyft/Kronos-Android