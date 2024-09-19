import 'package:user_app_web/api/api_client.dart';
import 'package:user_app_web/interfaces/repository_interface.dart';

abstract class ChatRepositoryInterface extends RepositoryInterface {
  @override
  Future getList({int? offset, bool conversationList = false, String? type, bool searchConversationalList = false, String? name});
  Future<dynamic> getMessages(int offset, int? userID, String userType, int? conversationID);
  Future<dynamic> sendMessage(String message, List<MultipartBody> images, int? userID, String userType, int? conversationID);
}
