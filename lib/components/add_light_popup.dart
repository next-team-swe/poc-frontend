import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void addLightPopup (context, areaId) {
  final name = TextEditingController();
  showDialog(context: context, builder: (context) => AlertDialog(
    title: const Text("Add light"),
    content: TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
      ),
      controller: name,
    ),
    actions: [
      TextButton(
        onPressed: () {
          if (name.text == "") {
            return;
          }else{
            Supabase.instance.client.from('light').insert([
              {
                'name': name.text,
                'area': areaId,
              }
              // per qualche motivo senza il catch non funziona
            ]).catchError((onError) {
              print(onError);
            });
            Navigator.pop(context);
          }
        },
        child: const Text("Add"))
    ]),
  );
}