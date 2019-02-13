import 'dart:async';
import 'dart:convert';

import 'package:Convention_Geek/about.dart';
import 'package:Convention_Geek/annuaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'index.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

   static Widget buildMainDrawer(context) {

    return new ListView(

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
            //Navigator.pop(context);
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
        Divider(),
        ListTile(
          title: Text('Version Web'),
          onTap: _launchURL,
        ),
        Divider(),
        ListTile(
          subtitle: Text("Version: " + "1.99.1"),
          onTap: _launchURL,
        ),
      ],
    );
  }

   static _launchURL() async {
     const url = 'https://www.convention-geek.fr/';
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Convention Geek',
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
      home: new HomePage(),
    );
  }
}

