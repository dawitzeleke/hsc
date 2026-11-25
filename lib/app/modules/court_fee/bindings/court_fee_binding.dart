import 'package:get/get.dart';
import '../controllers/court_fee_controller.dart';

class CourtFeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourtFeeController>(() => CourtFeeController());
  }
}
