import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final homeData = <String, dynamic>{}.obs;
  final detailsData = <String, dynamic>{}.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    try {
      isLoading.value = true;
      final String response =
          await rootBundle.loadString('assets/data/v1.json');
      final Map<String, dynamic> decoded =
          Map<String, dynamic>.from(jsonDecode(response));
      homeData.value =
          Map<String, dynamic>.from(decoded['home'] ?? <String, dynamic>{});
      detailsData.value =
          Map<String, dynamic>.from(decoded['details'] ?? <String, dynamic>{});
    } catch (e, st) {
      developer.log('Error loading v1.json',
          name: 'HomeController', error: e, stackTrace: st);
    } finally {
      isLoading.value = false;
    }
  }
}
