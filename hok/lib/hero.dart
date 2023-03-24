import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HeroesPage extends StatelessWidget {
  const HeroesPage({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _loadHeroes() async {
    final response = await http
        .get(Uri.parse('https://pvp.qq.com/web201605/js/herolist.json'));
    if (response.statusCode == 200) {
      final jsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final heroes = jsonData.map((data) {
        return {
          'name': data['cname'],
          'title': data['title'],
          'image':
              'https://game.gtimg.cn/images/yxzj/img201606/heroimg/${data['ename']}/${data['ename']}.jpg',
        };
      }).toList();
      return heroes;
    } else {
      throw Exception('Failed to load heroes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('英雄')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadHeroes(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('加载失败：${snapshot.error}'));
            } else {
              final heroes = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: heroes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final hero = heroes[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Image.network(hero['image']),
                          title: Text(hero['name']),
                          subtitle: Text(hero['title']),
                          onTap: () {
                            // 处理英雄点击事件
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
