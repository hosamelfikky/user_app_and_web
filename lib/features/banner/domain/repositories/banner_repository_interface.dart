import 'package:user_app_web/interfaces/repository_interface.dart';

abstract class BannerRepositoryInterface implements RepositoryInterface {
  @override
  Future getList(
      {int? offset,
      bool isBanner = false,
      bool isTaxiBanner = false,
      bool isFeaturedBanner = false,
      bool isParcelOtherBanner = false,
      bool isPromotionalBanner = false});
}
