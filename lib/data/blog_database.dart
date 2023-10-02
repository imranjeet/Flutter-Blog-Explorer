import 'package:blog_explorer_app/models/blog_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BlogDatabase {
  static final BlogDatabase instance = BlogDatabase._privateConstructor();
  static Database? _database;

  BlogDatabase._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'blog_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Blogs (
        id TEXT PRIMARY KEY,
        title TEXT,
        imageUrl TEXT,
        isFavorite INTEGER
      )
      ''');
  }

  Future<void> insertBlog(Blog blog) async {
    final db = await database;
    await db.insert(
      'Blogs',
      blog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Blog>> retrieveBlogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Blogs');
    return List.generate(maps.length, (i) {
      return Blog.fromMap(maps[i]);
    });
  }

  Future<void> updateBlog(Blog blog) async {
    final db = await database;
    await db.update(
      'Blogs',
      blog.toMap(),
      where: 'id = ?',
      whereArgs: [blog.id],
    );
  }

  Future<List<Blog>> retrieveFavoriteBlogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Blogs',
      where: 'isFavorite = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return Blog.fromMap(maps[i]);
    });
  }
}
