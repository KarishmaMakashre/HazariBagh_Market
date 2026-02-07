import 'package:flutter/material.dart';

class VendorNotificationScreen extends StatelessWidget {
  const VendorNotificationScreen({super.key});

  // Sample dummy notifications
  final List<Map<String, String>> notifications = const [
    {
      "title": "New Order Received",
      "subtitle": "You have received a new order #12345",
      "time": "2 mins ago"
    },
    {
      "title": "Store Approved",
      "subtitle": "Your store has been approved successfully",
      "time": "1 hour ago"
    },
    {
      "title": "New Message",
      "subtitle": "Customer sent a message regarding order #12344",
      "time": "Yesterday"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 20),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications, color: Colors.blue),
            title: Text(
              item['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item['subtitle']!),
            trailing: Text(
              item['time']!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              // Handle notification tap
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Tapped: ${item['title']}")),
              );
            },
          );
        },
      ),
    );
  }
}
