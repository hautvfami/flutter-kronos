import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_kronos/flutter_kronos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentTimeMs = -1;
  int? _currentNtpTimeMs = -1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    int currentTimeMs;
    int? currentNtpTimeMs;
    // Platform messages may fail, so we use a try/catch PlatformException.
    FlutterKronos.sync();
    try {
      currentTimeMs = (await FlutterKronos.getCurrentTimeMs)!;
      currentNtpTimeMs = await FlutterKronos.getCurrentNtpTimeMs;
    } on PlatformException {
      currentTimeMs = -1;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _currentTimeMs = currentTimeMs;
      _currentNtpTimeMs = currentNtpTimeMs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Current time is: $_currentTimeMs\n'),
              Text('Current ntp time is: $_currentNtpTimeMs\n')
            ],
          ),
        ),
      ),
    );
  }
}
