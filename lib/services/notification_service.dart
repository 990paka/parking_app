import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// FCM (токен, push в foreground) + локальное уведомление
/// при успешной регистрации.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _channel = AndroidNotificationDetails(
    'main_channel',
    'Основные уведомления',
    importance: Importance.high,
    priority: Priority.high,
  );

  String? token;

  Future<void> init() async {
    await _fcm.requestPermission();

    await _local.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    token = await _fcm.getToken();
    debugPrint('FCM token: $token');
    _fcm.onTokenRefresh.listen((t) => token = t);

    // push, пришедший пока приложение открыто
    FirebaseMessaging.onMessage.listen((message) {
      final n = message.notification;
      if (n != null) show(n.title ?? '', n.body ?? '');
    });
  }

  Future<void> show(String title, String body) {
    return _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(android: _channel),
    );
  }
}
