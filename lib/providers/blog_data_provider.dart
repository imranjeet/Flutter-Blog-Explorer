import 'package:flutter/foundation.dart';
import 'package:blog_explorer_app/models/blog_model.dart';
import 'package:blog_explorer_app/data/blog.dart';
import 'package:blog_explorer_app/data/blog_database.dart';

class BlogDataProvider with ChangeNotifier {
  List<Blog> _blogs = [];
  List<Blog> _favoriteBlogs = [];
  final BlogDatabase _database = BlogDatabase.instance;

  List<Blog> get blogs => _blogs;
  List<Blog> get favoriteBlogs => _favoriteBlogs;
  bool isDataFetched = false;

  Future<List<Blog>> fetchBlogs() async {
    if (isDataFetched == true) return _blogs;
    try {
      _blogs = await _database.retrieveBlogs();
      _updateFavoriteBlogs(); // Update the favorite blogs
      isDataFetched = true;
      notifyListeners();
      return _blogs;
    } catch (e) {
      _blogs = await getBlogsForApi();
      await _updateDatabase(_blogs); // Update the local database
      isDataFetched = true;
      notifyListeners();
      return _blogs;
    }
  }

  Future<void> _updateDatabase(List<Blog> blogs) async {
    for (final blog in blogs) {
      await _database.insertBlog(blog);
    }
  }

  void toggleFavorite(Blog blog) {
    final blogIndex = _blogs.indexWhere((element) => element.id == blog.id);

    if (blogIndex != -1) {
      _blogs[blogIndex].toggleFavorite();
      _database.updateBlog(blog);
      _updateFavoriteBlogs();
      notifyListeners();
    }
  }

  Future<void> _updateFavoriteBlogs() async {
    _favoriteBlogs = await _database.retrieveFavoriteBlogs();
    notifyListeners();
  }
}
