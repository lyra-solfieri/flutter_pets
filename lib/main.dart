import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pets_app/api.dart';
import 'package:pets_app/pet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BuildListView(),
    );
  }
}

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  var pets = new List<Pet>();
  int imgIndex = 0;

  void _prevImg() {
    setState(() {
      imgIndex = imgIndex > 0 ? imgIndex - 1 : 0;
    });
  }

  void _nextImg() {
    setState(() {
      imgIndex = imgIndex < pets.length - 1 ? imgIndex + 1 : imgIndex;
    });
  }

  _getPets() {
    API.getPets().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        pets = list.map((model) => Pet.fromJson(model)).toList();
      });
    });
  }

  _BuildListViewState() {
    _getPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Pets"),
        ),
        body: listaPets());
  }

  listPetsName() {
    return ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pets[index].name),
          );
        });
  }

  listaPets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            pets[imgIndex].name +
                "| Preço " +
                pets[imgIndex].price.toString() +
                ",00",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Center(
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                      image: NetworkImage(pets[imgIndex].picture),
                      fit: BoxFit.cover)),
              height: 400.0,
              width: 300.0,
            )
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Anterior'),
              onPressed: _prevImg,
              elevation: 5.0,
              color: Colors.green,
            ),
            SizedBox(width: 10.0),
            RaisedButton(
              child: Text('Proximo'),
              onPressed: _nextImg,
              elevation: 5.0,
              color: Colors.blue,
            )
          ],
        ),
        Text('Comidas'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Gosta: " + pets[imgIndex].food['likes'].toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Não gosta: " + pets[imgIndex].food['dislikes'].toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
        RaisedButton(
          child: Text('Sair'),
          onPressed: () => exit(0),
          elevation: 5.0,
          color: Colors.purple,
        ),
      ],
    );
  }
}
