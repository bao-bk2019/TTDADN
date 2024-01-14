import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class LocalNotificationService{
  LocalNotificationService();
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  Future<void> intialize() async{
    const AndroidInitializationSettings androidInitializationSettings =  AndroidInitializationSettings('@drawable/ic_stat_access_alarm');
    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await _localNotificationService.initialize(settings, );
  }
  Future<NotificationDetails> _notificationDetail() async{
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.max,
        ticker: 'ticker',
        playSound: true,
    );
    return const NotificationDetails(
      android: androidNotificationDetails,
    );
  }
  Future<void> showNotifiCation({
    required int id,
    required String title,
    required String body,
}) async{
    final detail = await _notificationDetail();
    await _localNotificationService.show(id, title, body, detail);
  }
}