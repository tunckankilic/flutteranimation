import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const HomePage(),
    );
  }
}

const widthAndHeight = 100.0; // Size of the sides of the cube

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _xController; // Controller for X-axis rotation
  late AnimationController _yController; // Controller for Y-axis rotation
  late AnimationController _zController; // Controller for Z-axis rotation
  late Tween<double> _animation; // Tween to define the range of rotation

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers with different durations
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    // Define the range of the animation (0 to 2*pi radians)
    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Start the animations
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: widthAndHeight, // Space above the cube
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge([
                _xController,
                _yController,
                _zController,
              ]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(
                        _animation.evaluate(_xController)) // Apply X rotation
                    ..rotateY(
                        _animation.evaluate(_yController)) // Apply Y rotation
                    ..rotateZ(
                        _animation.evaluate(_zController)), // Apply Z rotation
                  child: Stack(
                    children: [
                      // Back face
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(Vector3(0, 0, -widthAndHeight)),
                        child: Container(
                          color: Colors.purple,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      // Left face
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2.0),
                        child: Container(
                          color: Colors.red,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      // Right face
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-pi / 2.0),
                        child: Container(
                          color: Colors.blue,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      // Front face
                      Container(
                        color: Colors.green,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),
                      // Top face
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-pi / 2.0),
                        child: Container(
                          color: Colors.orange,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      // Bottom face
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi / 2.0),
                        child: Container(
                          color: Colors.brown,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
