import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_requests/api/articles_api.dart';
import 'package:http_requests/core/server_connector.dart';
import 'package:http_requests/model/article_model.dart';

import 'api/users_api.dart';
import 'package:http_requests/model/user_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Demo"),
          ),
          body: Center(
            child: Column(
              children: [
                buildUsers(),
                const SizedBox(height: 20),
                buildArticles(),
                ElevatedButton(
                  onPressed: () async {
                    final id = Random().nextInt(100) + 10;
                    final article = ArticleModel(
                      id: '$id',
                      post: 'Added new $id',
                      bgURL: 'https://loremflickr.com/640/480/abstract',
                      createdAt:
                          DateTime.now().millisecondsSinceEpoch.toString(),
                    );
                    await ArticlesAPI().postArticle(article);
                    Fluttertoast.showToast(msg: "Posted id:$id");
                  },
                  child: const Text("Add new"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<ArticleModel>> buildArticles() {
    return FutureBuilder(
      future: ArticlesAPI().getArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final article = snapshot.data ?? [];
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: article.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(article[index].bgURL),
                      Container(color: Colors.black45),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          article[index].post,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    ServerConnector.client.close();
    super.dispose();
  }
}

FutureBuilder<List<UserModel>> buildUsers() {
  return FutureBuilder(
    future: UsersAPI().getUsers(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      final users = snapshot.data ?? [];
      return SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: 100,
                    width: 100,
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(users[index].avatar),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    users[index].name,
                    maxLines: 1,
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
