import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static void scheduleNotification(int id, DateTime date, String eventName, String userName) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'basic_channel',
            title: 'Hello $userName',
            body: 'Your event "$eventName" is starting soon!',
            notificationLayout: NotificationLayout.Default,
            ),
            schedule: NotificationCalendar.fromDate(date: date)
            );
  }

  // cancel the notification while updating a notification
  static void cancelNotification(int id) {
    AwesomeNotifications().cancel(id);
  }
}
 