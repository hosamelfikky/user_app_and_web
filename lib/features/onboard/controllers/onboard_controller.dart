import 'package:get/get.dart';

import '../domain/models/onboarding_model.dart';
import '../domain/service/onboard_service_interface.dart';

class OnBoardingController extends GetxController implements GetxService {
  final OnboardServiceInterface onboardServiceInterface;
  OnBoardingController({required this.onboardServiceInterface});

  List<OnBoardingModel> _onBoardingList = [];
  List<OnBoardingModel> get onBoardingList => _onBoardingList;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void getOnBoardingList() async {
    Response response = await onboardServiceInterface.getOnBoardingList();
    if (response.statusCode == 200) {
      _onBoardingList = [];
      _onBoardingList.addAll(response.body);
      _onBoardingList.add(OnBoardingModel('', '', ''));
    }
    update();
  }
}
