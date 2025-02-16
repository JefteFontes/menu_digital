import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../data/models/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';


final commentProvider = StateNotifierProvider<CommentNotifier, List<Comment>>((ref) => CommentNotifier());

class CommentNotifier extends StateNotifier<List<Comment>> {
  CommentNotifier() : super([]);

  final String _baseUrl = 'https://avali-app-menudigital-default-rtdb.firebaseio.com/comments.json';
  final user = FirebaseAuth.instance.currentUser;

  Future<void> fetchComments() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data != null) {
        state = data.entries.map((entry) => Comment.fromJson(entry.key, entry.value)).toList();
      }
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<void> addComment(Comment comment) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: json.encode(comment.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String id = json.decode(response.body)['name'];
      state = [
        ...state,
        Comment(
          id: id,
          userName: comment.userName,
          text: comment.text,
          imageUrl: comment.imageUrl,
          date: comment.date,
        )
      ];
    } else {
      throw Exception('Failed to add comment');
    }
  }
}