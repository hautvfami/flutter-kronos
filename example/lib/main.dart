import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kronos/flutter_kronos.dart';

class _MyAppState extends State<MyApp> {
  int? _currentTimeMs;
  int? _currentNtpTimeMs;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    FlutterKronos.sync();
    try {
      _currentTimeMs = await FlutterKronos.getCurrentTimeMs;
      _currentNtpTimeMs = await FlutterKronos.getCurrentNtpTimeMs;
    } on PlatformException {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  _refreshTime() async {
    final result = await Future.wait([
      FlutterKronos.getCurrentTimeMs,
      FlutterKronos.getCurrentNtpTimeMs,
    ]);
    _currentTimeMs = result[0];
    _currentNtpTimeMs = result[1];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plugin example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current time: $_currentTimeMs'),
            Text('Current time: ${_currentTimeMs.stringify}\n'),
            Text('Current ntp time: $_currentNtpTimeMs'),
            Text('Current ntp time: ${_currentNtpTimeMs.stringify}'),
            ElevatedButton(
              onPressed: _refreshTime,
              child: Text('Refresh'),
            ),
            ElevatedButton(
              onPressed: () async {
                _currentTimeMs = null;
                _currentNtpTimeMs = null;

                setState(() {});
              },
              child: Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}

extension TimeConvert on int? {
  String get stringify => this == null || this! <= 0
      ? ''
      : DateTime.fromMillisecondsSinceEpoch(this!).toString();
}

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
