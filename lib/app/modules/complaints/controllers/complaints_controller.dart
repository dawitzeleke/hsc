import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintItem {
  final String id;
  final String title;
  final String category;
  final String date;
  final String status;
  final String statusNote;
  final String courtOffice;
  final String judgeName;
  final String description;
  final String caseNumber;
  final String incidentDate;
  final String contactName;
  final String contactPhone;
  final String attachmentName;
  final String attachmentSize;

  const ComplaintItem({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.status,
    required this.statusNote,
    this.courtOffice = 'Harari Supreme Court',
    this.judgeName = '',
    this.description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    this.caseNumber = '00/0001/23',
    this.incidentDate = '22 Nov, 2026',
    this.contactName = 'Bereket Nigussie',
    this.contactPhone = '+251912345678',
    this.attachmentName = 'Attachment.pdf',
    this.attachmentSize = '248 KB',
  });

  Map<String, String> toArguments() => {
        'id': id,
        'title': title,
        'category': category,
        'date': date,
        'status': status,
        'statusNote': statusNote,
        'courtOffice': courtOffice,
        'judgeName': judgeName,
        'description': description,
        'caseNumber': caseNumber,
        'incidentDate': incidentDate,
        'contactName': contactName,
        'contactPhone': contactPhone,
        'attachmentName': attachmentName,
        'attachmentSize': attachmentSize,
      };
}

class ComplaintsController extends GetxController {
  // 0 = auth gate, 1 = login, 2 = signup, 3 = complaints list
  final currentPage = 0.obs;
  final isLoggedIn = false.obs;
  final selectedFilter = 0.obs;
  final searchQuery = ''.obs;

  final complaints = <ComplaintItem>[
    const ComplaintItem(
      id: 'CMP-2026-0148',
      title: 'Delay in receiving a court document',
      category: 'Service delay',
      date: '06 Nov 2026',
      status: 'In review',
      statusNote: 'Assigned to the court service team',
    ),
    const ComplaintItem(
      id: 'CMP-2026-0132',
      title: 'Incorrect information on case record',
      category: 'Case records',
      date: '02 Nov 2026',
      status: 'In review',
      statusNote: 'Received · Awaiting review',
    ),
    const ComplaintItem(
      id: 'CMP-2026-0096',
      title: 'Unable to access hearing schedule',
      category: 'Online services',
      date: '24 Oct 2026',
      status: 'Resolved',
      statusNote: 'Resolved on 29 Oct 2026',
    ),
  ].obs;

  // Login fields
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final showLoginPassword = false.obs;

  // Signup fields
  final signupPhoneController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmController = TextEditingController();
  final showSignupPassword = false.obs;
  final showSignupConfirm = false.obs;

  void goToLogin() => currentPage.value = 1;
  void goToSignup() => currentPage.value = 2;
  void goToAuthGate() => currentPage.value = 0;

  void addComplaint(ComplaintItem item) {
    complaints.insert(0, item);
  }

  List<ComplaintItem> get filteredComplaints {
    final query = searchQuery.value.trim().toLowerCase();
    return complaints.where((c) {
      final matchesFilter = selectedFilter.value == 0 ||
          (selectedFilter.value == 1 && c.status == 'In review') ||
          (selectedFilter.value == 2 && c.status == 'Resolved');
      final matchesQuery = query.isEmpty ||
          c.title.toLowerCase().contains(query) ||
          c.id.toLowerCase().contains(query) ||
          c.category.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  int get pendingCount =>
      complaints.where((c) => c.status == 'In review').length;

  int get resolvedCount =>
      complaints.where((c) => c.status == 'Resolved').length;

  void login() {
    isLoggedIn.value = true;
    currentPage.value = 3;
  }

  void signup() {
    isLoggedIn.value = true;
    currentPage.value = 3;
  }

  void logout() {
    isLoggedIn.value = false;
    currentPage.value = 0;
    loginPhoneController.clear();
    loginPasswordController.clear();
    signupPhoneController.clear();
    signupPasswordController.clear();
    signupConfirmController.clear();
  }

  @override
  void onClose() {
    loginPhoneController.dispose();
    loginPasswordController.dispose();
    signupPhoneController.dispose();
    signupPasswordController.dispose();
    signupConfirmController.dispose();
    super.onClose();
  }
}
