import 'package:flutter/material.dart';
import 'services/services.dart';
import 'app.dart';

void main() {
  Services().initNotifications();
  runApp(const App());
}
