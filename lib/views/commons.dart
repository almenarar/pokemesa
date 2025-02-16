import 'package:flutter/material.dart';

BoxDecoration backgroundDecoration() {
  return BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/grass.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: .60), BlendMode.darken),
          ),
        );
}