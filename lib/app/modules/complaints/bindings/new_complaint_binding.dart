import 'package:get/get.dart';
import '../controllers/new_complaint_controller.dart';

class NewComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewComplaintController>(() => NewComplaintController());
  }
}
