import 'dart:async';
import 'dart:convert';

import 'package:Convention_Geek/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import 'DateFormatClass.dart';
import 'index.dart';
import 'annuaire.dart';

class EventPage extends StatefulWidget {

  final String eventid;

  EventPage({Key key, @required this.eventid}) : super(key: key);

  @override
  _EventPageState createState() => new _EventPageState();
}


class _EventPageState extends State<EventPage> {

  Map<String, dynamic> data;

  get eventid => null;

  Future<String> getData() async {

    final response =
    await http.get(
        Uri.encodeFull('https://www.convention-geek.fr/api/event/'+widget.eventid),
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


  String _parseHtmlString(String htmlString) {

    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }

  Widget _buildEventTitle() {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return new Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        _parseHtmlString(data["eventname"]),
        style: textTheme.title,
        softWrap: true,),
    );
  }

  Widget _buildEventPlace() {
    return new Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        "L'évènement: " + _parseHtmlString(data["eventname"]) + "est un évènement qui a lieu à " +
            _parseHtmlString(data["eventlieu"]) + " dans le " + data["eventdepartement"]["departement_code"]+ " - " + data["eventdepartement"]["departement_nom"],
        softWrap: true,),
    );
  }

  Widget _buildEventDescription() {
    return new Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        _parseHtmlString(data["eventdescription"]),
        softWrap: true,),
    );
  }

  Widget _buildEventTitleDates() {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return new Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        _parseHtmlString("Les différentes éditions"),
        style: textTheme.subtitle,
        softWrap: true,),
    );
  }

  Widget _buildEventDates() {
    return new Expanded(
      //child: _buildSuggestions(),
        child: _buildSuggestions()
    );
  }

  Widget _buildSuggestions() {
    return new ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: data["eventdatelist"] == null ? 0 : data["eventdatelist"].length,
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
      leading: new Text(data["eventdatelist"][i]["edition"].toString()),
      title: new Text(
          DateFormatClass.getDisplayDate(data["eventdatelist"][i]["datedebut"], data["eventdatelist"][i]["datefin"])
      ),
      trailing: data["eventdatelist"][i]["visiteurs"] == null ? new Text("-") : new Text(data["eventdatelist"][i]["visiteurs"].toString())
      ,
    );
  }

  @override
  Widget build(BuildContext context) {

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
      body: Column(
        children: [
          _buildEventTitle(),
          _buildEventPlace(),
          _buildEventDescription(),
          _buildEventTitleDates(),
          _buildEventDates(),
        ],
      )
    );
  }
}
