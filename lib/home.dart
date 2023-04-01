import 'package:flutter/material.dart';
import 'package:purplepay_task/ERC20Flow/erc20flow.dart';
import 'package:purplepay_task/Notifications/notifications.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ERC20FlowScreen(),
                      ));
                },
                child: Text("ERC20 Flow")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ));
                },
                child: Text("Notification"))
          ],
        ),
      ),
    );
  }
}
