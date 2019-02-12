import 'dart:async';
import 'dart:convert';

import 'package:Convention_Geek/about.dart';
import 'package:Convention_Geek/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'DateFormatClass.dart';
import 'index.dart';

class AnnuairePage extends StatefulWidget {
  AnnuairePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _AnnuairePageState createState() => new _AnnuairePageState();
}


class _AnnuairePageState extends State<AnnuairePage> {

  List data;

  Future<String> getData() async {

    final response =
    await http.get(
        Uri.encodeFull('https://www.convention-geek.fr/api/annuaire'),
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
          data[i]["nom"]
      ),
      subtitle: new Text(
          data[i]["lieu"] + " - " + data[i]["departement"]["departement_code"] + " - " + data[i]["departement"]["departement_nom"]
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => (EventPage(eventid: data[i]["eventid"]))),
        );
      }
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (HomePage())),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (AnnuairePage())),
                );
              },
            ),
            ListTile(
              title: Text('À propos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (AboutPage())),
                );
              },
            ),
          ],
        ),
      ),
      body: _buildSuggestions(),
    );
  }
}
