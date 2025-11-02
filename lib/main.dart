import 'package:app/control_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final alphaProvider = NotifierProvider<AlphaNotifier, int>(AlphaNotifier.new);

class AlphaNotifier extends Notifier<int> {
  @override
  int build() {
    return 0x33;
  }

  void setAlpha(int alpha) {
    state = alpha;
  }
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

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int alpha = ref.watch(alphaProvider);

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
            child: LiquidGlassLayer(
              settings: LiquidGlassSettings(
                thickness: 20,
                blur: 10,
                glassColor: Color(alpha << 24 | 0xFFFFFF),
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
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return ControlPanel(scrollController: scrollController);
            },
          ),
        ],
      ),
    );
  }
}
