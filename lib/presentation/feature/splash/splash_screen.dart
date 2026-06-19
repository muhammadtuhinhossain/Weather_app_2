import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app2/presentation/feature/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1200));
    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnim = Tween(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 2500), _navigateHome);
  }

  void _navigateHome(){
    if(!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.indigo,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.sun_max_fill, size: 80,color: Colors.white,),
                  SizedBox(height: 16,),
                  Text('weather',style: TextStyle(color: Colors.white,fontSize: 36,fontWeight: .w300,letterSpacing: 4),),
                  SizedBox(height: 8,),
                  Text('Real-time forecasts',style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                    letterSpacing: 1.5,
                  ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}