import 'package:flutter/material.dart';

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  FadeIndexedStackState createState() => FadeIndexedStackState();
}

class FadeIndexedStackState extends State<FadeIndexedStack> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _previousIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });
    // Start at 1.0 so initial render is fully visible
    _controller.forward(from: 1.0);
    _previousIndex = widget.index;
    super.initState();
  }

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _previousIndex = oldWidget.index;
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fadeOut = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );
    final fadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
    );
    final slideIn = Tween<Offset>(begin: const Offset(0.0, 0.02), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    final children = <Widget>[];
    Widget? currentChild;

    for (int i = 0; i < widget.children.length; i++) {
      final child = KeyedSubtree(
        key: ValueKey(i),
        child: widget.children[i],
      );

      final isCurrent = i == widget.index;
      final isPrevious = i == _previousIndex;

      if (isCurrent) {
        currentChild = IgnorePointer(
          ignoring: _controller.isAnimating,
          child: FadeTransition(
            opacity: fadeIn,
            child: SlideTransition(
              position: slideIn,
              child: child,
            ),
          ),
        );
      } else if (isPrevious && _controller.isAnimating) {
        children.add(IgnorePointer(
          child: FadeTransition(
            opacity: ReverseAnimation(fadeOut),
            child: child,
          ),
        ));
      } else {
        children.add(Offstage(offstage: true, child: child));
      }
    }

    if (currentChild != null) {
      children.add(currentChild);
    }

    return Stack(
      fit: StackFit.expand,
      children: children,
    );
  }
}
