import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/api_client.dart';
import '../../../../util/app_constants.dart';
import '../models/notification_model.dart';
import 'notification_repository_interface.dart';

class NotificationRepository implements NotificationRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  NotificationRepository({required this.apiClient, required this.sharedPreferences});

  @override
  Future<List<NotificationModel>?> getList({int? offset}) async {
    List<NotificationModel>? notificationList;
    Response response = await apiClient.getData(AppConstants.notificationUri);
    if (response.statusCode == 200) {
      notificationList = [];
      response.body.forEach((notification) => notificationList!.add(NotificationModel.fromJson(notification)));
    }
    return notificationList;
  }

  @override
  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(AppConstants.notificationCount, count);
  }

  @override
  int? getSeenNotificationCount() {
    return sharedPreferences.getInt(AppConstants.notificationCount);
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
