import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        buttonColor: Colors.purple,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        )
      ),
      home: const MyHomePage(),
    );
  }
}

class Kitten {
  const Kitten({ this.name, this.description, this.age, this.imageUrl });

  final String name;
  final String description;
  final int age;
  final String imageUrl; 
}

final List<Kitten> _kittens = <Kitten>[
  Kitten(
    age: 11,
    description: 'He\'s the fucking cutest.',
    imageUrl: 'https://www.am570.com.br/images/posts/1119/1119.jpg',
    name: "Jonny"
  ),
  Kitten(
    age: 12,
    description: 'He\'s adorable.',
    imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/416zV9V2ydL._SX331_BO1,204,203,200_.jpg',
    name: "Thom"
  ),
];

class MyHomePage extends StatelessWidget{
  const MyHomePage({ Key key }) : super(key: key);

  Widget _dialogBuilder(BuildContext context, Kitten kitten) {
    ThemeData localTheme = Theme.of(context);

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        Image.network(
          kitten.imageUrl,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                kitten.name,
                style: localTheme.textTheme.display1,
              ),
              Text(
                '${kitten.age} months old',
                style: localTheme.textTheme.subhead.copyWith(
                  fontStyle: FontStyle.italic
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                kitten.description,
                style: localTheme.textTheme.body1,
              ),
              SizedBox(height: 16.0),
              Align(
              child: Wrap(
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('I\M ALLERGIC'),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: const Text('ADOPT')
                  ),
                ],
              )
            )
            ],
          ),
        )
      ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () => showDialog(
        context: context, 
        builder: (context) => _dialogBuilder(context, _kittens[index])),
      child: Container(
      padding: const EdgeInsets.only(left: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(_kittens[index].name,
      style: Theme.of(context).textTheme.headline),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Kittens'),
      ),
      body: ListView.builder(
        itemCount: _kittens.length,
        itemExtent: 60.0, // Height of Each items.,
        itemBuilder: _listItemBuilder,
      ),
    );
  }
}