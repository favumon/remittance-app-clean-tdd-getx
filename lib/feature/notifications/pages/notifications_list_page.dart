import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/feature/notifications/widgets/notification_list.dart';

class NotificationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('notifications'.tr),
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: NotificationsList(),
      ),
    );
  }
}
