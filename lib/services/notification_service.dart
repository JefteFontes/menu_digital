import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class Notification{
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  Notification({required this.id, this.title, this.body, this.payload});
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones(); // Inicializa o suporte para fusos horários

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Lógica ao clicar na notificação
        print("Notificação clicada: ${response.payload}");
      },
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  Future<void> showNotification({required Notification notification, required Duration delay}) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'pedidos_finalizados', // ID do canal
      'Pedidos', // Nome do canal
      channelDescription: 'Notificação de pedidos',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    final date = DateTime.now().add(delay);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(date, tz.local),
      details,
      payload: notification.payload,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<String?> getInitialPayload() async {
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    return details?.didNotificationLaunchApp ?? false ? details?.notificationResponse?.payload : null;
  }
}