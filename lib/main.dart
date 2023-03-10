import 'package:flutter/material.dart';
import 'package:poc_frontend/pages/light_page.dart';
import 'package:poc_frontend/pages/list_area.dart';
import 'package:poc_frontend/components/list_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/light.dart';
import 'pages/list_light_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://banraxrzqacvpzsonavh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJhbnJheHJ6cWFjdnB6c29uYXZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzczMzkzNTksImV4cCI6MTk5MjkxNTM1OX0.gRfvdnzSN_jBTmi2iY1GPOK10flQIp_tUgyeRD3K90I',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumos Minima',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Lumos Minima'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const AreasPage();
  }
}
