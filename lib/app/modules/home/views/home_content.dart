import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
// AppHeader is now the shared header widget (renamed from HomeHeader)
import '../widgets/service_banner.dart';
import '../widgets/action_card.dart';
import '../widgets/appointments_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppHeader(),
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: ServiceBanner()),
              const SliverToBoxAdapter(child: ActionCards()),
              const SliverToBoxAdapter(child: AppointmentsSection()),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ],
    );
  }
}
