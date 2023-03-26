import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:battery_status/battery_status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _batteryStatusPlugin = BatteryStatus();

  String _platformVersion = 'Unknown';
  bool? _isCharging;
  double? _value;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initBatteryIsCharging();
    initBatteryValue();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _batteryStatusPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initBatteryIsCharging() async {
    bool? isCharging;
    try {
      isCharging = await _batteryStatusPlugin.isCharging();
    } on PlatformException {
      isCharging = null;
    }
    if (!mounted) return;
    setState(() {
      _isCharging = isCharging;
    });
  }

  Future<void> initBatteryValue() async {
    double? value;
    try {
      value = await _batteryStatusPlugin.value();
    } on PlatformException {
      value = null;
    }
    if (!mounted) return;
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battery Status Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              _isCharging == null || _value == null
                  ? const Icon(Icons.question_mark_rounded)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bolt_rounded),
                        Text("${(_value! * 100).toInt()}")
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
