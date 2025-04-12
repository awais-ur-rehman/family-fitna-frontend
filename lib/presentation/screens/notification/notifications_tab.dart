// File: lib/presentation/screens/notification/notifications_tab.dart

import 'package:flutter/material.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('Notifications will appear here'),
      ),
    );
  }
}