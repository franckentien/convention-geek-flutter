import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'DateFormatClass.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primaryColor: new Color.fromRGBO(120, 10, 10, 1.0),
        accentColor: new Color.fromRGBO(0, 77, 22, 1.0)
            
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List data;

  Future<String> getData() async {

    final response =
    await http.get(
        Uri.encodeFull('https://www.convention-geek.fr/api/next-events'),
        headers: {
          "Accept": 'application/json'
        }
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      this.setState((){
        data = json.decode(response.body);
      });
      return "Success!";

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState(){
    this.getData();
  }


  Widget _buildSuggestions() {
    return new ListView.separated(

        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.
            return _buildRow(i);
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  Widget _buildRow(int i) {
    return new ListTile(

      title: new Text(
        data[i]["name"] + ' - ' + data[i]["place"]
      ),
      subtitle: new Text(
          DateFormatClass.getDisplayDate(data[i]["datedebut"], data[i]["datefin"])

      ),

      trailing: new Text(
          data[i]["informateur"]
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

     return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new SvgPicture.asset('assets/banniere.svg')
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: new SvgPicture.asset('assets/banniere.svg'),

              decoration: BoxDecoration(
                color: new Color.fromRGBO(120, 10, 10, 1.0),
              ),
            ),
            ListTile(
              title: Text('Conventions'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context);
              },
            ),
//            ListTile(
//              title: Text('News'),
//              onTap: () {
//                // Update the state of the app
//                // ...
//                Navigator.pop(context);
//              },
//            ),
            ListTile(
              title: Text('Annuaire'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('À propos'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _buildSuggestions(),
    );
  }
}
