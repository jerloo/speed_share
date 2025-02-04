import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:signale/signale.dart';

class SettingController extends GetxController {
  SettingController();
  bool enableFilter = false;
  bool enableServer = true;

  @override
  void onInit() {
    super.onInit();
    Log.w('$this init');
  }

  @override
  void onReady() {
    super.onReady();
    Log.w('$this onReady');
  }

  void filterEnabledChange(bool value) {
    enableFilter = value;
    update();
  }

  void serverEnableChange(bool value) {
    enableServer = value;
    update();
  }
}
