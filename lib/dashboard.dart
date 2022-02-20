import 'package:flutter/material.dart';
import './utils/utils.dart';

class DashboardScreen extends StatelessWidget {
  static String routeName = 'dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                logUserOut(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Welcome'),
      ),
    );
  }
}
