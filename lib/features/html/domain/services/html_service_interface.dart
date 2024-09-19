import 'package:get/get.dart';
import 'package:user_app_web/util/html_type.dart';

abstract class HtmlServiceInterface {
  Future<Response> getHtmlText(HtmlType htmlType);
}
