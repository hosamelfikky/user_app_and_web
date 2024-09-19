import 'package:user_app_web/interfaces/repository_interface.dart';
import 'package:user_app_web/util/html_type.dart';

abstract class HtmlRepositoryInterface extends RepositoryInterface {
  Future<dynamic> getHtmlText(HtmlType htmlType);
}
