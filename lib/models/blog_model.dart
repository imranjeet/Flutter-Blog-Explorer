class Blog {
  final String id;
  final String title;
  final String imageUrl;
  bool isFavorite;

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  factory Blog.fromJson(Map<String, dynamic> map) {
    return Blog(
      id: map['id'],
      title: map['title'],
      imageUrl: map['image_url'],
      isFavorite: false,
    );
  }

}
