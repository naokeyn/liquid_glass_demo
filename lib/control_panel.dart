import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlPanel extends ConsumerStatefulWidget {
  const ControlPanel({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  ConsumerState<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends ConsumerState<ControlPanel> {
  int sliderValue = 0x33;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        controller: widget.scrollController,
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Alpha", style: Theme.of(context).textTheme.titleMedium),
              Slider(
                min: 0x00,
                max: 0xFF,
                value: sliderValue.toDouble(),
                divisions: 0xFF,
                label:
                    '0x${sliderValue.toRadixString(16).toUpperCase().padLeft(2, '0')}',
                onChanged:
                    (value) => {
                      sliderValue = value.toInt(),
                      ref.read(alphaProvider.notifier).state = sliderValue,
                    },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
