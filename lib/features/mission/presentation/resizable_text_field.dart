import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/tokens/app_colors.dart';

class ResizableTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle style;
  final InputDecoration decoration;
  final double minHeight;
  final double maxHeight;

  const ResizableTextField({
    super.key,
    required this.controller,
    required this.style,
    required this.decoration,
    this.minHeight = 300.0,
    this.maxHeight = 600.0,
  });

  @override
  State<ResizableTextField> createState() => _ResizableTextFieldState();
}

class _ResizableTextFieldState extends State<ResizableTextField> {
  late double _height;

  @override
  void initState() {
    super.initState();
    _height = widget.minHeight;
  }

  @override
  Widget build(BuildContext context) {
    // Respecter le responsive : la hauteur max ne dépasse pas 60% de l'écran ou la valeur maxHeight (600)
    final responsiveMaxHeight = math.min(
      widget.maxHeight,
      MediaQuery.of(context).size.height * 0.6,
    );
    // S'assurer que le minimum ne dépasse pas le responsiveMaxHeight
    final safeMinHeight = math.min(widget.minHeight, responsiveMaxHeight);

    // Corriger la hauteur si l'écran a été redimensionné
    if (_height > responsiveMaxHeight) {
      _height = responsiveMaxHeight;
    }
    if (_height < safeMinHeight) {
      _height = safeMinHeight;
    }

    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: context.cSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: TextField(
              controller: widget.controller,
              maxLines: null,
              expands: true,
              style: widget.style,
              decoration: widget.decoration,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _height += details.delta.dy;
                  if (_height < safeMinHeight) {
                    _height = safeMinHeight;
                  } else if (_height > responsiveMaxHeight) {
                    _height = responsiveMaxHeight;
                  }
                });
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeUpDown,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: const Icon(
                    Icons.drag_indicator,
                    size: 16,
                    color: Colors.grey,
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
