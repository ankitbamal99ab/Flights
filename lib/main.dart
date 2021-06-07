import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.redAccent,
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flights',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _origin,_destination ;
   var count=0;
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample2.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }
  // Ankit Till now
  // Bamal after Airport
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Flights',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [

            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(

                    // ignore: missing_return
                    validator: (input){
                      if(input.isEmpty)
                        return 'Please provide value';
                    },
                    onChanged:(input)=>_origin=input,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                        labelText: 'Origin'
                    ),
                  ),
                  TextFormField(
                    // ignore: missing_return
                    validator: (input){
                      if(input.isEmpty)
                        return 'Please provide value';
                    },
                    onChanged:(input)=>_destination=input,
                    decoration: InputDecoration(
                        labelText: 'Destination'
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Search'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _items.length > 0
                ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,

                itemBuilder: (context, index) {
                  if(_items[index]["Origin"]==_origin && _items[index]["Destination"]==_destination)
                  // if(1==1)
                  {
                    count++;
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(

                        leading: Text(_items[index]["Origin"]),
                        title: Text(_items[index]["Destination"]),
                        subtitle: Text(_items[index]["Via"]),
                      ),
                    );

                  }
                  else
                    // ignore: missing_return
                    {
                      return Container();
                    }
                },
              ),
            )
                : Container(
              child: Text("No Such values Present"),
            ),
            Container(
              child: Text(count.toString()),
            ),
          ],
        ),
      ),
    );
  }
}