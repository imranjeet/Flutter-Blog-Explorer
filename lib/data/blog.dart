import 'dart:convert';
import 'package:blog_explorer_app/models/blog_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:blog_explorer_app/data/blog_database.dart';

Future<List<Blog>> getBlogsForApi() async {
  const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  const String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      List<dynamic> blogList = json.decode(response.body)['blogs'];
      return blogList.map((json) => Blog.fromJson(json)).toList();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong..");
      throw Exception('Failed to load blogs');
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Something went wrong..");
    throw Exception('Failed to load blogs');
  }
}

Future<List<Blog>> fetchBlogsOffline() async {
  final db = BlogDatabase.instance;
  return await db.retrieveBlogs();
}
