import 'package:flutter/material.dart';

class TopRightBadge extends StatelessWidget {
  const TopRightBadge({
    super.key,
    required this.child,
    required this.data,
    this.color,
  });

  final Widget child;
  final Object data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            constraints: const BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            child: Text(
              data.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white
              ),
            ),
          ),
        )
      ],
    );
  }
}