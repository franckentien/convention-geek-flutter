import 'dart:async';
import 'dart:convert';

import 'package:Convention_Geek/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'DateFormatClass.dart';
import 'index.dart';
import 'annuaire.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _AboutPageState createState() => new _AboutPageState();
}


class _AboutPageState extends State<AboutPage> {

  @override
  void initState(){

  }

  Widget _buildPresentation() {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return new Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Présentation",
              style: textTheme.title,
              softWrap: true,),
            const ListTile(
              title: Text("Le site Convention Geek a été créé durant l’été 2014 par Franck CAYZAC, étudiant en programmation informatique.\n" +
                  "J’ai commencé mes premières conventions en 2013 et je voulais en faire plus, mais à l’époque il était très difficile de trouver les conventions autour de chez moi, c’est donc sur cette idée que j’ai créé Convention Geek et qui aujourd’hui est devenu le premier site pour connaitre les conventions. Très rapidement après la création du site j’ai également mis en place une partie news dans laquelle vous pouvez retrouver mon retour sur les conventions avec le point de vue d’un visiteur.\n\n" +
                  "Depuis 2014, le site a subi de gros changements avec un an après sa sortie l’ajout d’une page pour chaque évènement et l’historique des dates, mais également la sortie de la version 2 qui est la version actuelle du site. Néanmoins, je ne compte pas m’arrêter là. Je vais continuer à développer de nombreuses fonctionnalités pour le site qui vont rendre Convention Geek indispensable.\n\n" +
                  "En attendant, je vous souhaite une bonne visite sur le site et vous donne rendez-vous en conventions pour plus de fun.\n",
                softWrap: true,),

            ),

          ],
        ),
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
        _buildPresentation()

        ]
      ),
    );
  }
}
