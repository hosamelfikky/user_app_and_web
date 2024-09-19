import 'package:user_app_web/interfaces/repository_interface.dart';

abstract class NotificationRepositoryInterface extends RepositoryInterface {
  void saveSeenNotificationCount(int count);
  int? getSeenNotificationCount();
}
