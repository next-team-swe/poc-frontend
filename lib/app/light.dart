import 'dart:core';

class Light {
  String name;
  final int id;
  bool state;
  int brightness;
  int area;

  Light({
    required this.name,
    required this.id,
    required this.state,
    required this.brightness,
    required this.area,
  });
}