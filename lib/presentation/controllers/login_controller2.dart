import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/sign_upinstascreen.dart';
import '../pages/home_instascreen.dart';

class LoginController extends GetxController {
  var obscurePassword = true.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  Future<void> loginUser() async {
    isLoading.value = true;

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    final String apiUrl = 'http://192.168.100.12:8000/api/login';

    try {
      print("email: $email");
      print("password: $password");

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        errorMessage.value = '';
        // Navigate to the next screen upon successful login
        //Get.off(() => HomeInstaScreen());
      } else {
        isLoading.value = false;
        errorMessage.value = 'Identifiants incorrects. Veuillez réessayer.';
      }
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
      errorMessage.value = 'Une erreur s\'est produite. Veuillez réessayer.';
    }
  }
}
