import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import 'package:hsc/app/routes/app_pages.dart';
import '../controllers/complaints_controller.dart';

class ComplaintsList extends StatelessWidget {
  const ComplaintsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ComplaintsController>();

    return Column(
      children: [
        // Search + New button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 20, color: Colors.grey.shade400),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search complaint...',
                            hintStyle:
                                TextStyle(color: Colors.grey.shade400, fontSize: 14),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 18, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        'New',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Filter tabs
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Obx(() => Row(
                children: [
                  _filterChip('All (3)', 0, controller),
                  const SizedBox(width: 8),
                  _filterChip('Pending (2)', 1, controller),
                  const SizedBox(width: 8),
                  _filterChip('Resolved (1)', 2, controller),
                ],
              )),
        ),
        // Complaint cards
        Expanded(
          child: Obx(() {
            final complaints = _getFilteredComplaints(controller.selectedFilter.value);
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              itemCount: complaints.length,
              itemBuilder: (_, i) => _ComplaintCard(data: complaints[i]),
            );
          }),
        ),
      ],
    );
  }

  Widget _filterChip(String label, int index, ComplaintsController controller) {
    final selected = controller.selectedFilter.value == index;
    return GestureDetector(
      onTap: () => controller.selectedFilter.value = index,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.onPrimary : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  List<_ComplaintData> _getFilteredComplaints(int filter) {
    final all = [
      _ComplaintData(
        id: 'CMP-2026-0148',
        title: 'Delay in receiving a court document',
        category: 'Service delay',
        date: '06 Nov 2026',
        status: 'In review',
        statusNote: 'Assigned to the court service team',
      ),
      _ComplaintData(
        id: 'CMP-2026-0132',
        title: 'Incorrect information on case record',
        category: 'Case records',
        date: '02 Nov 2026',
        status: 'In review',
        statusNote: 'Received · Awaiting review',
      ),
      _ComplaintData(
        id: 'CMP-2026-0096',
        title: 'Unable to access hearing schedule',
        category: 'Online services',
        date: '24 Oct 2026',
        status: 'Resolved',
        statusNote: 'Resolved on 29 Oct 2026',
      ),
    ];

    if (filter == 1) return all.where((c) => c.status == 'In review').toList();
    if (filter == 2) return all.where((c) => c.status == 'Resolved').toList();
    return all;
  }
}

class _ComplaintData {
  final String id, title, category, date, status, statusNote;
  _ComplaintData({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.status,
    required this.statusNote,
  });
}

class _ComplaintCard extends StatelessWidget {
  final _ComplaintData data;
  const _ComplaintCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final isResolved = data.status == 'Resolved';
    final statusColor = isResolved
        ? const Color(0xFF16A34A)
        : const Color(0xFFD97706);

    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.COMPLAINT_DETAIL,
        arguments: {'id': data.id, 'status': data.status},
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ID + status badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.id,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      data.status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Title + chevron
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade400),
            ],
          ),
          const SizedBox(height: 4),
          // Category + date
          Text(
            '${data.category} · ${data.date}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 6),
          // Status note
          Text(
            data.statusNote,
            style: TextStyle(
              fontSize: 12,
              color: isResolved ? const Color(0xFF16A34A) : const Color(0xFFD97706),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
    );
  }
}
