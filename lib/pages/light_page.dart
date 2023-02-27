import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../app/light.dart';
import '../components/text_container.dart';

class LightPage extends StatefulWidget {
  final Light light;
  final Stream<dynamic> lightStream;

  LightPage({Key? key, required this.light})
      : lightStream = Supabase.instance.client
            .from("light")
            .stream(primaryKey: ["id"]).eq("id", light.id),
        super(key: key);

  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.lightStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data[0]["name"]),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: SleekCircularSlider(
                        initialValue: snapshot.data[0]["brightness"].toDouble(),
                        min: 0,
                        max: 100,
                        appearance: CircularSliderAppearance(
                          customColors: CustomSliderColors(
                            trackColor: Colors.green.shade100,
                            progressBarColors: [
                              Colors.lime,
                              Colors.lime.shade600,
                              Colors.lightGreen,
                              Colors.green.shade300
                            ],
                            gradientStartAngle: 0,
                            gradientEndAngle: 180,
                            dynamicGradient: true,
                            dotColor: Colors.grey.shade100,
                          ),
                          customWidths: CustomSliderWidths(
                            progressBarWidth: 15,
                            handlerSize: 10,
                          ),
                          size: 250,
                          animationEnabled: false,
                        ),
                        onChangeEnd: (double value) async {
                          await Supabase.instance.client
                              .from("light")
                              .update({"brightness": value.toInt()}).eq(
                                  "id", snapshot.data[0]["id"]);
                        },
                        innerWidget: (double value) => IconButton(
                          icon: Icon(snapshot.data[0]["state"]
                              ? Icons.lightbulb
                              : Icons.lightbulb_outline),
                          tooltip: snapshot.data[0]["state"]
                              ? "Turn off"
                              : "Turn on",
                          color: snapshot.data[0]["state"]
                              ? Colors.yellow.shade700
                              : Colors.grey,
                          iconSize: 100,
                          onPressed: () async {
                            await Supabase.instance.client
                                .from("light")
                                .update({
                              "state": !snapshot.data[0]["state"]
                            }).eq("id", snapshot.data[0]["id"]);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    TextContainer(
                      child: Text("ID: ${snapshot.data[0]["id"].toString()}"),
                    ),
                    TextContainer(
                      child: Text(
                          "Brightness: ${snapshot.data[0]["brightness"].toString()}"),
                    ),
                    TextContainer(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              color: snapshot.data[0]["connected"]
                                  ? Colors.green
                                  : Colors.red,
                              width: 15,
                              height: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(snapshot.data[0]["connected"]
                              ? "Online"
                              : "Offline"),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: Supabase.instance.client
                          .from("area")
                          .select("name")
                          .eq("id", snapshot.data[0]["area"]),
                      builder: _areaContainerBuilder,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Text("Error: ${snapshot.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }

  Widget _areaContainerBuilder(BuildContext context, AsyncSnapshot snapshot) {
    final Widget child;
    if (snapshot.hasData) {
      child = _areaContainer(snapshot.data[0]["name"], true, context);
    } else {
      child = _areaContainer("Loading...", false, context);
    }

    return TextContainer(
      child: child,
    );
  }

  Widget _areaContainer(String name, bool isEditable, BuildContext context) =>
      FutureBuilder(
        future: Supabase.instance.client.from("area").select(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final List<dynamic> areas = snapshot.data as List<dynamic>;

            return PopupMenuButton(
              itemBuilder: (context) {
                return List.generate(
                  areas.length,
                      (index) => PopupMenuItem(
                    value: areas[index]["id"],
                    child: Text(areas[index]["name"]),
                  ),
                );
              },
              onSelected: _areaSelected,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Area: $name"),
                  const Icon(Icons.edit),
                ],
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Area: $name"),
                const CircularProgressIndicator(),
              ],
            );
          }
        },
      );

  void _areaSelected(dynamic areaId) async {
    await Supabase.instance.client.from("light").update({'area':areaId}).match({'id': widget.light.id});
  }

}
