import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/list_item.dart';

class ListLightPage extends StatelessWidget{
  const ListLightPage({super.key, required this.areaId});

  final int areaId;

  @override
  Widget build(BuildContext context) {
    final lightStream= Supabase.instance.client.from('light').stream(primaryKey: ['id']).eq("area", areaId);


    return Scaffold(
      appBar: AppBar(
        title: Text("area $areaId", style: TextStyle(fontFamily: 'norwester')),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: lightStream,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return LightListItem(snapshot: snapshot, index: index);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: null,
    );
  }
}