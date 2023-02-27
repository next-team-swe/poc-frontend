import 'package:flutter/material.dart';

class area {
  final int id;
  final String name;
  final String imageUrl;

  area({required this.id, required this.name, required this.imageUrl});
}

class Areas extends StatefulWidget {
  const Areas({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Areas> createState() => _Areas();
}

class _Areas extends State<Areas> {
  final List<area> items = [
    area(
      id: 1,
      name: 'Padova prato',
      imageUrl:
          'https://images.placesonline.com/photos/424012309201110_Padova_722344240.jpg?quality=80&w=700',
    ),
    area(
      id: 2,
      name: 'New York centro',
      imageUrl:
          'https://images.placesonline.com/photos/424010310171223_NewYork_152295734.jpg?quality=80&w=700',
    ),
    area(
      id: 3,
      name: 'Roma centro storico',
      imageUrl:
          'https://a.cdn-hotels.com/gdcs/production40/d811/5e89ad90-8f10-11e8-b6b0-0242ac110007.jpg?impolicy=fcrop&w=1600&h=1066&q=medium',
    ),
    area(
      id: 4,
      name: 'Padova corso stati uniti',
      imageUrl:
          'https://citynews-padovaoggi.stgy.ovh/~media/horizontal-mid/3880745918562/corso-stati-uniti-via-lisbona-2.jpg',
    ),
    area(
      id: 5,
      name: 'Venezia P.zz Roma',
      imageUrl:
          'https://tourismmedia.italia.it/is/image/mitur/1600X1600_venezia_ponte_tramonto?wid=400&hei=400&fit=constrain,1&fmt=webp',
    ),
  ]; //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: new Text(widget.title, textAlign: TextAlign.center)),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
                // set the crossAxisAlignment property to center,
                mainAxisAlignment: MainAxisAlignment.start,
                // set the crossAxisAlignment property to center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Wrap(
                    spacing: 10,
                    runSpacing: 20,
                    children: items.map((item) {
                      return GestureDetector(
                          onTap: () {
                            print(item.id);
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(item.imageUrl),
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
                                    end: Alignment(0, -0.2),
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(item.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )))),
                              ),
                            ],
                          ));
                    }).toList(),
                  )
                ]),
          ),
        ));
  }
}
