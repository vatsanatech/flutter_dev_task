import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class PostListTab extends StatelessWidget {
  const PostListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: Provider.of<PostProvider>(context).getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Post> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Title : ${posts[index].title}",style: const TextStyle(fontSize: 20),),
                  subtitle: Text(posts[index].body),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PostProvider with ChangeNotifier {
  final Dio _dio = Dio();

  Future<List<Post>> getPosts() async {
    try {
      Response response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      List<Post> posts = (response.data as List).map((json) => Post.fromJson(json)).toList();
      return posts;
    } catch (error) {
      throw Exception('Failed to fetch posts: $error');
    }
  }
}

class Post {
  final String userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
