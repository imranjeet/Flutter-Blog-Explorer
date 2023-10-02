import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer_app/models/blog_model.dart';
import 'package:blog_explorer_app/providers/blog_data_provider.dart';

class FavoriteButton extends StatelessWidget {
  final Blog blog;

  const FavoriteButton({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogDataProvider>(builder: (context, value, child) {
      return IconButton(
        icon: Icon(
          blog.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: blog.isFavorite ? Colors.red : null,
        ),
        onPressed: () {
          
          value.toggleFavorite(blog);
        },
      );
    });
  }
}
