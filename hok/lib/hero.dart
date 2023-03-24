import 'package:flutter/material.dart';

class HeroPage extends StatefulWidget {
  final dynamic hero;

  const HeroPage({Key? key, this.hero}) : super(key: key);

  @override
  HeroPageState createState() => HeroPageState();
}

class HeroPageState extends State<HeroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hero['name']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(widget.hero['image']),
            const SizedBox(height: 16.0),
            Text(widget.hero['name'],
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 8.0),
            Text(widget.hero['title'],
                style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}
