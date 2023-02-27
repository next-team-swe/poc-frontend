import 'dart:core';
import 'package:flutter/material.dart';


class Light {
  late String name;
  late final int id;
  late bool state;
  late int brightness;
  late int area;

  Light({
    required this.name,
    required this.id,
    required this.state,
    required this.brightness,
    required this.area,
  });

  // build light from snapshot
  Light.fromSnapshot(AsyncSnapshot<dynamic> snapshot, int index){
        name = snapshot.data![index]['name'];
        id = snapshot.data![index]['id'];
        state = snapshot.data![index]['state'];
        brightness = snapshot.data![index]['brightness'];
        area = snapshot.data![index]['area'];
  }
}