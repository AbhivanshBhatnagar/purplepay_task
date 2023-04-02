import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              AwesomeNotifications().createNotification(
                  content: NotificationContent(
                      id: Random().nextInt(100),
                      channelKey: "basic_channel",
                      title: "Payment has been completed",
                      body: "Thank you."));
            },
            child: Text("Completed")),
      ),
    );
  }
}
