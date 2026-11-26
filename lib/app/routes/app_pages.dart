import 'package:get/get.dart';

import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/follow_up/bindings/follow_up_binding.dart';
import '../modules/follow_up/views/follow_up_view.dart';
import '../modules/complaints/views/complaint_detail_view.dart';
import '../modules/complaints/bindings/new_complaint_binding.dart';
import '../modules/complaints/views/new_complaint_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOW_UP,
      page: () => const FollowUpView(),
      binding: FollowUpBinding(),
    ),
    GetPage(
      name: _Paths.COMPLAINT_DETAIL,
      page: () => const ComplaintDetailView(),
    ),
    GetPage(
      name: _Paths.NEW_COMPLAINT,
      page: () => const NewComplaintView(),
      binding: NewComplaintBinding(),
    ),
  ];
}
