import 'package:flutter/material.dart';

class WeatherBackground extends StatelessWidget {
  final Widget child;

  const WeatherBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF79C6F4), Color(0xFF3C88C7), Color(0xFF173D72)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: -110,
            right: -80,
            child: _BackgroundGlow(color: Color(0x66FFFFFF), size: 270),
          ),
          const Positioned(
            top: 210,
            left: -120,
            child: _BackgroundGlow(color: Color(0x334CC9FF), size: 300),
          ),
          const Positioned(
            bottom: -170,
            right: -100,
            child: _BackgroundGlow(color: Color(0x332A5CAC), size: 360),
          ),
          child,
        ],
      ),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  final Color color;
  final double size;

  const _BackgroundGlow({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [BoxShadow(color: color, blurRadius: 90, spreadRadius: 30)],
      ),
    );
  }
}
