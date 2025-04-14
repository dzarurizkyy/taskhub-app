import 'dart:convert';

import 'package:taskhub_app/models/note.dart';
import 'package:http/http.dart' as http;

class NoteService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Note>> fetchNote() async {
    final response = await http.get(Uri.parse("$baseUrl/posts"));

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Note.fromJson(e)).toList();
    } else {
      throw Exception("failed to retrieve data");
    }
  }

  Future<bool> createNote(Note note) async {
    final response = await http.post(
      Uri.parse("$baseUrl/posts"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editNote(Note note) async {
    final response = await http.put(
      Uri.parse("$baseUrl/posts/${note.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(note.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteNote(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/posts/$id"));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
