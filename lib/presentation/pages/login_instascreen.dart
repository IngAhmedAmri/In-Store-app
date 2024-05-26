import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../pages/sign_upinstascreen.dart';
import '../pages/reset_password_screen.dart';
import '../pages/home_instascreen.dart';

class LoginInstaScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/Logo2.png',
            height: 50,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(() => TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        fillColor: controller.isEmailValid.value
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        filled: true,
                        errorText: controller.isEmailValid.value
                            ? null
                            : 'Email invalide',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) => controller.validateEmail(value),
                    )),
                SizedBox(height: 10.0),
                Obx(() => TextFormField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: Icon(controller.obscurePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        fillColor: controller.isPasswordValid.value
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        filled: true,
                        errorText: controller.isPasswordValid.value
                            ? null
                            : 'Mot de passe requis',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: controller.obscurePassword.value,
                      onChanged: (value) => controller.validatePassword(value),
                    )),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => ResetPasswordScreen());
                      },
                      child: Text(
                        'Mot de passe oublié?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 18, 19, 19),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                   // if (controller.validateInputs()) {
                      Get.off(() => HomeInstaScreen());
                   // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF15A0FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Obx(() => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Text(
                          'Se connecter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                SizedBox(height: 10.0),
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
                    Get.to(() => SignUpInstaScreen());
                  },
                  child: Text(
                    'Créer un compte',
                    style: TextStyle(
                      color: Color.fromARGB(255, 14, 15, 15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var obscurePassword = true.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void validateEmail(String email) {
    isEmailValid.value = GetUtils.isEmail(email);
  }

  void validatePassword(String password) {
    isPasswordValid.value = password.isNotEmpty;
  }

  bool validateInputs() {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    return isEmailValid.value && isPasswordValid.value;
  }
}
