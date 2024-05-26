import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/users_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward().then(
          (value) => Get.off(() => UsersScreen()),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: Stack(
          children: [
            Positioned.fill(
              top: -90,
              child: Image.asset(
                'assets/Formbackground.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  Container(
                    margin: EdgeInsets.only(
                        top:120), // Ajout de la marge supérieure pour le premier Image
                    child: Image.asset(
                      'assets/Logo1.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                  margin: EdgeInsets.only(top: 60), // Ajout de la marge supérieure pour le CircularProgressIndicator
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 9, 220, 216)),
                  ),
                ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 47,
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'SFProText-Semibold',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Container(
                      width: 77.401,
                      height: 13,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
