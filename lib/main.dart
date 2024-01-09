import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_task_flutter/post_tab.dart';
import 'package:stage_task_flutter/user_list.dart';

import 'comment_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (_)=>CommentProvider()),
     ],
      child:  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('STAGE Flutter Task'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'User List'),
              Tab(text: 'Posts'),
              Tab(text: 'Comments'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const UserNamesTab(),
            const PostListTab(),
            CommentListTab(),
          ],
        ),
      ),
    );
  }
}



