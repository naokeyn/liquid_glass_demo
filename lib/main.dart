import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int minAlpha = 0x00;
  final int maxAlpha = 0xFF;

  int _currentSliderValue = 0x33;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // This is the content that will be behind the glass
          Positioned.fill(
            child: Image.network(
              'https://picsum.photos/seed/glass/800/800',
              fit: BoxFit.cover,
            ),
          ),
          // The LiquidGlassLayer manages glass rendering
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LiquidGlassLayer(
                  settings: LiquidGlassSettings(
                    thickness: 20,
                    blur: 10,
                    glassColor: Color(_currentSliderValue << 24 | 0xFFFFFF),
                  ),
                  child: LiquidGlass(
                    shape: LiquidRoundedSuperellipse(borderRadius: 50),
                    child: const SizedBox(
                      height: 200,
                      width: 200,
                      child: Center(child: FlutterLogo(size: 100)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Slider(
                  value: _currentSliderValue.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _currentSliderValue = value.toInt();
                    });
                  },
                  min: minAlpha.toDouble(),
                  max: maxAlpha.toDouble(),
                ),
                Text(
                  'Alpha: 0x${_currentSliderValue.toRadixString(16).padLeft(2, '0').toUpperCase()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
