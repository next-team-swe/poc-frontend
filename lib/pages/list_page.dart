import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../pages/light_page.dart';

class LightListItem extends StatelessWidget {
  const LightListItem({super.key, required this.snapshot, required this.index});

  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      onTap:  () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LightPage(/* light */)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed:
              () async {
                await Supabase.instance.client.from('light').update({'state': !snapshot.data![index]['state']}).eq('id', snapshot.data![index]['id']);
              },
              icon: Icon(snapshot.data![index]['state'] ? Icons.lightbulb : Icons.lightbulb_outline, color: snapshot.data![index]['state'] ? Colors.yellow[700] : Colors.grey),
            ),
            Text(snapshot.data![index]['name'].toString()),
            Icon(Icons.circle, color: Random().nextBool() ? Colors.green : Colors.red),
          ]
        ),
      ),
    );
  }
}