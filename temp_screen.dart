import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to LoginScreen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CustomPaint(
          size: Size(150, 150),
          painter: BullHeadPainter(),
        ),
      ),
    );
  }
}

// Custom Painter for drawing the bull head
class BullHeadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.amber[700]! // Golden color
      ..style = PaintingStyle.fill;

    // Draw head (circle)
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.6), // center of the head
      size.width * 0.3, // radius
      paint,
    );

    // Draw left horn (triangle)
    Path leftHorn = Path();
    leftHorn.moveTo(size.width * 0.2, size.height * 0.3); // top point
    leftHorn.lineTo(size.width * 0.05, size.height * 0.7); // bottom left
    leftHorn.lineTo(size.width * 0.35, size.height * 0.5); // bottom right
    leftHorn.close();
    canvas.drawPath(leftHorn, paint);

    // Draw right horn (triangle)
    Path rightHorn = Path();
    rightHorn.moveTo(size.width * 0.8, size.height * 0.3); // top point
    rightHorn.lineTo(size.width * 0.95, size.height * 0.7); // bottom right
    rightHorn.lineTo(size.width * 0.65, size.height * 0.5); // bottom left
    rightHorn.close();
    canvas.drawPath(rightHorn, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = '';
  String _password = '';

  bool _isValidCredentials = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateLogin() {
    setState(() {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email == 'admin@123' && _password == 'admin123') {
        _isValidCredentials = true;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ));
      } else {
        _isValidCredentials = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                errorText: !_isValidCredentials && _email.isNotEmpty
                    ? "Incorrect email"
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                errorText: !_isValidCredentials && _password.isNotEmpty
                    ? "Incorrect password"
                    : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateLogin,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

// Home Page after successful login
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Text(
          "Welcome to the Home Page!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
