import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:scribe/decorators/colors/app_colors.dart';

class NotificationService {
  static void scheduleNotification(
      int id, DateTime date, String eventName, String userName) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          largeIcon: 'assets/images/scribe_new_logo.png',
          channelKey: 'basic_channel',
          title: '👋 Hello, <b>$userName</b>!',
          body: '🎉 Your event "<b>$eventName</b>" is starting soon!',
          notificationLayout: NotificationLayout.Default,
          color: gTabBackground,
          displayOnBackground: true,
          displayOnForeground: true,
        ),
        schedule: NotificationCalendar.fromDate(date: date));
  }

  // cancel the notification while updating a notification
  static void cancelNotification(int id) {
    AwesomeNotifications().cancel(id);
  }
}
