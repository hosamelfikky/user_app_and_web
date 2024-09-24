import 'package:image_picker/image_picker.dart';

import '../../../../common/models/response_model.dart';
import '../models/userinfo_model.dart';
import '../repositories/profile_repository_interface.dart';
import 'profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface {
  final ProfileRepositoryInterface profileRepositoryInterface;
  ProfileService({required this.profileRepositoryInterface});

  @override
  Future<UserInfoModel?> getUserInfo() async {
    return await profileRepositoryInterface.get(null);
  }

  @override
  Future<ResponseModel> updateProfile(UserInfoModel userInfoModel, XFile? data, String token) async {
    return await profileRepositoryInterface.updateProfile(userInfoModel, data, token);
  }

  @override
  Future<ResponseModel> changePassword(UserInfoModel userInfoModel) async {
    return await profileRepositoryInterface.changePassword(userInfoModel);
  }

  @override
  Future<ResponseModel> deleteUser() async {
    return await profileRepositoryInterface.delete(null);
  }
}
