import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/login_instascreen.dart';
import '../pages/login_companyscreen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation1;
  late Animation<Offset> _slideAnimation2;
  late Animation<Offset> _textSlideAnimation;
  late Animation<Offset> _textSlideAnimation2;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideAnimation1 = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0, 0.5, curve: Curves.easeInOut),
    ));

    _slideAnimation2 = Tween<Offset>(
      begin: Offset(1.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.5, 1, curve: Curves.easeInOut),
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0, 0.5, curve: Curves.easeInOut),
    ));

    _textSlideAnimation2 = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.5, 1, curve: Curves.easeInOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(height: 600.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Formbackground2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 50,
                  child: Image.asset(
                    'assets/Logo1.png', // Replace with your logo asset path
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 10,
                  child: Column(
                    children: [
                      SlideTransition(
                        position: _textSlideAnimation,
                        child: Padding(
                          padding: EdgeInsets.only(right: 80, bottom: 10),
                          child: Text(
                            'Instagrammeur',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation1,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => LoginInstaScreen());
                          },
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size(220, 190),
                                painter: TriangleBorderPainter(),
                              ),
                              ClipPath(
                                clipper: ShapeClipper(),
                                child: Image.asset(
                                  'assets/Instagrammeur.jpg',
                                  fit: BoxFit.cover,
                                  width: 220,
                                  height: 190,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 320,
                  right: 20,
                  child: SlideTransition(
                    position: _slideAnimation2,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => LoginCompanyScreen());
                      },
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: Size(220, 190),
                            painter: InverseTriangleBorderPainter(),
                          ),
                          ClipPath(
                            clipper: InverseShapeClipper(),
                            child: Image.asset(
                              'assets/Fournisseur.jpg',
                              fit: BoxFit.cover,
                              width: 220,
                              height: 190,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 530,
                  right: 30,
                  child: SlideTransition(
                    position: _textSlideAnimation2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 250, bottom: 0),
                      child: Text(
                        'Fournisseur',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
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

// Clipper for the first triangle
class ShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Clipper for the second triangle (inverse of the first)
class InverseShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Painter for the first triangle border
class TriangleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Painter for the second (inverse) triangle border
class InverseTriangleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
