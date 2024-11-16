import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/views/homePage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String _errorMessage = '';
  String _passwordErrorMessage = '';
  late AnimationController _bubbleController;
  late List<Bubble> _bubbles;


  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    // Initialize bubbles with random properties
    _bubbles = List.generate(15, (_) => Bubble());
  }
  @override
  void dispose() {
    _bubbleController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to validate the input
  void _validateInput(String value) {
    if (value.isEmpty) {
      setState(() {
        _errorMessage = 'This field cannot be empty';
      });
      return;
    }

    if (value.length == 10 && int.tryParse(value) != null) {
      setState(() {
        _errorMessage = '';
      });
    } else if (value.contains('@') && value.contains('.') && value.length > 5) {
      setState(() {
        _errorMessage = '';
      });
    } else {
      setState(() {
        _errorMessage = 'Please enter a valid Email or Mobile number';
      });
    }
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordErrorMessage = 'Password cannot be empty';
      });
    } else if (value.length < 8) {
      setState(() {
        _passwordErrorMessage = 'Password should be at least 8 characters long';
      });
    } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      setState(() {
        _passwordErrorMessage = 'Password must contain at least one lowercase letter';
      });
    } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      setState(() {
        _passwordErrorMessage = 'Password must contain at least one uppercase letter';
      });
    } else if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      setState(() {
        _passwordErrorMessage = 'Password must contain at least one number';
      });
    } else if (!RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
      setState(() {
        _passwordErrorMessage = 'Password must contain at least one special character';
      });
    } else {
      setState(() {
        _passwordErrorMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated bubbles as background effect
          AnimatedBuilder(
            animation: _bubbleController,
            builder: (context, child) {
              return Stack(
                children: _bubbles.map((bubble) {
                  // Update bubble position to float downwards
                  bubble.y += bubble.speed;
                  if (bubble.y > MediaQuery.of(context).size.height) {
                    bubble.y = -bubble.size; // Reset to top
                    bubble.x = Random().nextDouble() * MediaQuery.of(context).size.width;
                  }

                  return Positioned(
                    left: bubble.x,
                    top: bubble.y,
                    child: Opacity(
                      opacity: bubble.opacity,
                      child: Container(
                        width: bubble.size,
                        height: bubble.size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bubble.color,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width > 600
                      ? 500
                      : MediaQuery.of(context).size.width - 32,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white70,
                        offset: Offset(0, 3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Login Here...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(18, 66, 210, 1),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _validateInput(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Email or Mobile',
                          labelStyle: const TextStyle(color: Colors.blue, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.email_outlined, color: Color.fromRGBO(18, 66, 210, 1)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        onChanged: (value) {
                          _validatePassword(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.blue, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline, color: Color.fromRGBO(18, 66, 210, 1)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_passwordErrorMessage.isNotEmpty)
                        Text(
                          _passwordErrorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          // email/phone and password
                          String emailOrPhone = _emailController.text;
                          String password = _passwordController.text;

                          // validation for email/phone
                          bool isEmailOrPhoneValid = (emailOrPhone.isNotEmpty &&
                              (emailOrPhone.contains('@') && emailOrPhone.contains('.')) ||
                              emailOrPhone.length == 10 && int.tryParse(emailOrPhone) != null);

                          //  validation for password
                          bool isPasswordValid = password.isNotEmpty && password.length >= 8 &&
                              RegExp(r'^(?=.*[a-z])').hasMatch(password) &&
                              RegExp(r'^(?=.*[A-Z])').hasMatch(password) &&
                              RegExp(r'^(?=.*\d)').hasMatch(password) &&
                              RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password);

                          if (isEmailOrPhoneValid && isPasswordValid)  {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid email/phone or password')),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(18, 66, 210, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}



// Bubble class to represent each bubble
class Bubble {
  double x;
  double y;
  double size;
  double speed;
  double opacity;
  Color color;

  Bubble()
      : x = Random().nextDouble() * 400, // Random x position
        y = Random().nextDouble() * 800, // Random y position
        size = Random().nextDouble() * 30 + 10, // Random size between 10-40
        speed = Random().nextDouble() * 1.5 + 0.1, // Random speed between 0.5-2.5
        opacity = Random().nextDouble() * 0.5 + 0.2, // Random opacity between 0.2-0.7
        color = Colors.blue.withOpacity(Random().nextDouble() * 0.5 + 0.2); // Random blue color with opacity
}

