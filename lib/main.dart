import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';

import 'package:abstergo_flutter/abstergo.dart';
import 'dsn.dart';

final SentryClient _sentry = new SentryClient(dsn: dsn);

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');
  print('Reporting to Sentry.io...');

  final SentryResponse response = await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry.io: ${response.error}');
  }
}

main() { 
  FlutterError.onError = (FlutterErrorDetails details) async {
    await _reportError(details.exception, details.stack);
  };

  Isolate.current.addErrorListener(new RawReceivePort((dynamic pair) async {
    print('Isolate.current.addErrorListener caught an error');
    await _reportError(
      (pair as List<String>).first,
      (pair as List<String>).last,
    );
  }).sendPort);

  runZoned<Future<Null>>(() async {
    runApp(Abstergo());
  }, onError: (error, stackTrace) async {
    print('Zone caught an error');
    await _reportError(error, stackTrace);
  });
 
}
