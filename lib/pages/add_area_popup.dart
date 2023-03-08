import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddAreaPopup extends StatelessWidget{
  const AddAreaPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final areaDesc = TextEditingController();
    final areaImage = TextEditingController();
    final city = TextEditingController();
    final region = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Area", style: TextStyle(fontFamily: 'norwester')),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // flutter text input
              Padding(
                padding:  const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Area Name',
                  ),
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Area Description',
                  ),
                  controller: areaDesc,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Area image',
                  ),
                  controller: areaImage,
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    }
                ),
              ),
              Padding(
                padding:  const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City Name',
                  ),
                  controller: city,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  }
                ),
              ),
              Padding(
                padding:  const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Region',
                  ),
                  controller: region,
                ),
              ),
              // submit the form
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Processing Data')));
                    Supabase.instance.client.from('area').insert([
                      {
                        'name': name.text,
                        'description': areaDesc.text.isEmpty ? '' : areaDesc.text,
                        'image_url': areaImage.text,
                        'city': city.text,
                        'region': region.text.isEmpty ? '' : region.text,
                      }
                    ]).then((value) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],),
        )

      ),
      floatingActionButton: null,
    );
  }
}