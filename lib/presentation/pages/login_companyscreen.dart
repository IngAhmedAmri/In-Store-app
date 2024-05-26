import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller2.dart';
import '../pages/sign_upcompanyscreen.dart';
import '../pages/reset_password_screen.dart';

class LoginCompanyScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connexion Entreprises',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
        ),
        backgroundColor: Colors.white, 
        elevation: 0, 
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20), 
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(), 
                  filled: true,
                  fillColor: Colors.blue[50], 
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  suffixIcon: IconButton(
                    onPressed: controller.togglePasswordVisibility,
                    icon: Obx(() => Icon(controller.obscurePassword.value
                        ? Icons.visibility
                        : Icons.visibility_off)),
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.blue[50], 
                ),
                obscureText: controller.obscurePassword.value,
              ),
              SizedBox(height: 10), 
              TextButton(
                onPressed: () {
                  Get.to(() => ResetPasswordScreen());
                },
                child: Text(
                  'Mot de passe oublié?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {
                  controller.loginUser();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Text(
                        'Se connecter',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
              ),
              if (controller.errorMessage.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    controller.errorMessage.value,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Vous n'avez pas de compte?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => SignUpCompanyScreen());
                },
                child: Text(
                  'Créer un compte',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
