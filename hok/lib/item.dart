import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  final dynamic item;

  const ItemPage({Key? key, this.item}) : super(key: key);

  @override
  ItemPageState createState() => ItemPageState();
}

class ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['item_name']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(widget.item['image']),
            const SizedBox(height: 16.0),
            Text(widget.item['item_name'],
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 8.0),
            Text(widget.item['des1'].replaceAll(RegExp(r'<[^>]+>'), ''),
                style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}
