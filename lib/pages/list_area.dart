import 'package:flutter/material.dart';
import 'package:poc_frontend/pages/list_light_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/area.dart';

class AreasPage extends StatefulWidget {
  const AreasPage({Key? key}) : super(key: key);

  final String title = 'Lumus Minima';

  @override
  State<AreasPage> createState() => _Areas();
}

class _Areas extends State<AreasPage> {
  final arealiststream = Supabase.instance.client.from('area').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title, textAlign: TextAlign.center)),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: StreamBuilder<Object>(
                    stream: arealiststream,
                    builder: (context, snapshot) {                      
                      if (snapshot.hasData && snapshot.data != null) {
                        final List<dynamic> areas = snapshot.data as List<dynamic>;
                        return Column(
                            // set the crossAxisAlignment property to center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            // set the crossAxisAlignment property to center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Wrap(
                                spacing: 10,
                                runSpacing: 20,
                                children: 
                                areas.map((item) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return ListLightPage(areaId: item['id']);
                                          })
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(item['image_url']),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: const Alignment(0, -0.2),
                                                colors: [
                                                  Colors.black.withOpacity(0.5),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 10, horizontal: 20),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(item['name'],
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                        )))),
                                          ),
                                        ],
                                      ));
                                }).toList(),
                              )
                            ]);
                      }else {
                        return const CircularProgressIndicator();
                      }
                    }
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
