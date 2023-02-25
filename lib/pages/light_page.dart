import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../app/light.dart';
import '../components/text_container.dart';

class LightPage extends StatefulWidget {
  final Light light;

  const LightPage({Key? key, required this.light}) : super(key: key);

  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextContainer(
          child: Text(widget.light.name),
        ),
        TextContainer(
          child: Text(widget.light.id.toString()),
        ),
      ],
    );
  }
}
