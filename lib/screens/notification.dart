import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taqwalife/generated/l10n.dart';
import 'package:taqwalife/providers/notification_provider.dart';
import 'package:timeago/timeago.dart' as timeago;


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    setupFCM(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              localization.notifications,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  provider.clearNotifications();
                },
              )
            ],
          ),
          body: Center(
            child: provider.notifications.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off, size: 80, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        localization.no_new_notifications,
                        style: const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: provider.notifications.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final notification = provider.notifications[index];
                      final timestamp = DateTime.parse(notification['timestamp']);
                      final timeAgo = timeago.format(timestamp, locale: Localizations.localeOf(context).languageCode);

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          leading: notification['imageUrl'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    notification['imageUrl']!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.image_not_supported, color: Colors.grey);
                                    },
                                  ),
                                )
                              : const Icon(Icons.notifications, color: Colors.teal),
                          title: Text(
                            notification['text']!,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                          subtitle: Text(
                            timeAgo,
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

// Function to set up FCM notifications
Future<void> setupFCM(BuildContext context) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission on iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Get the token
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  // Listen to foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    String? notificationBody = message.notification?.body;
    String? imageUrl = message.notification?.android?.imageUrl ?? message.notification?.apple?.imageUrl;

    final provider = Provider.of<NotificationProvider>(context, listen: false);
    provider.addNotification(notificationBody ?? "New Notification", imageUrl: imageUrl);
  });

  // Handle when the app is opened from a notification
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notification opened app: ${message.data}');

    String? notificationBody = message.notification?.body;
    String? imageUrl = message.notification?.android?.imageUrl ?? message.notification?.apple?.imageUrl;

    final provider = Provider.of<NotificationProvider>(context, listen: false);
    provider.addNotification(notificationBody ?? "Opened Notification", imageUrl: imageUrl);
  });
}
