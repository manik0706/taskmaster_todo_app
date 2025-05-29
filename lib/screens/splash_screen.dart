// Create a new file: lib/screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _textController;
  late Animation<double> _iconAnimation;
  late Animation<double> _textAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _iconController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _textController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Setup animations
    _iconAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.elasticOut,
    ));

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    // Start animations
    _iconController.forward();
    Timer(Duration(milliseconds: 600), () {
      _textController.forward();
    });

    // Navigate to home screen after delay
    Timer(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Icon
            AnimatedBuilder(
              animation: _iconAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _iconAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Checklist items
                        Positioned(
                          left: 20,
                          top: 25,
                          child: Column(
                            children: [
                              // Completed item
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 8,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    width: 40,
                                    height: 2,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Completed item
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 8,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    width: 30,
                                    height: 2,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Pending item
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey[400]!,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    width: 35,
                                    height: 2,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Plus button
                        Positioned(
                          right: 15,
                          bottom: 15,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF5722),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40),

            // Animated Text
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _textAnimation,
                child: Column(
                  children: [
                    Text(
                      'TaskMaster',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Organize your life, one task at a time',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 60),

            // Loading indicator
            FadeTransition(
              opacity: _textAnimation,
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}