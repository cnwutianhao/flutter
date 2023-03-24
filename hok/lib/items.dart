import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hok/item.dart';
import 'package:http/http.dart' as http;

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _loadItems() async {
    final response =
        await http.get(Uri.parse('https://pvp.qq.com/web201605/js/item.json'));
    if (response.statusCode == 200) {
      final jsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final items = jsonData.map((data) {
        return {
          'item_name': data['item_name'],
          'des1': data['des1'],
          'image':
              'https://game.gtimg.cn/images/yxzj/img201606/itemimg/${data['item_id']}.jpg',
        };
      }).toList();
      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('装备')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadItems(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('加载失败：${snapshot.error}'));
            } else {
              final items = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Image.network(item['image']),
                          title: Text(item['item_name']),
                          subtitle: Text(
                              item['des1'].replaceAll(RegExp(r'<[^>]+>'), '')),
                          onTap: () {
                            // 跳转到装备详情页
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemPage(item: item)),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
