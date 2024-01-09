import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class CommentListTab extends StatelessWidget {
  const CommentListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Comment>>(
        future: Provider.of<CommentProvider>(context).getComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
           else {
            List<Comment> comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Post Id ${comments[index].postId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${comments[index].name}'),
                      Text('Comments: ${comments[index].body}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CommentProvider with ChangeNotifier {
  final Dio _dio = Dio();

  Future<List<Comment>> getComments() async {
    try {
      Response response = await _dio.get('https://jsonplaceholder.typicode.com/comments');
      List<Comment> comments =
      (response.data as List).map((json) => Comment.fromJson(json)).toList();
      return comments;
    } catch (error) {
      throw Exception('Failed to fetch comments: $error');
    }
  }
}

class Comment {
  final int postId;
  final String id;
  final String name;
  final int email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
