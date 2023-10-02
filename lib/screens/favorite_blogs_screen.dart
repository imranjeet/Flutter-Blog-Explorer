import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer_app/providers/blog_data_provider.dart';

import '../widgets/favorite_button.dart';

class FavoriteBlogsScreen extends StatelessWidget {
  const FavoriteBlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Blogs'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Consumer<BlogDataProvider>(builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.favoriteBlogs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                value.favoriteBlogs[index].imageUrl),
                            fit: BoxFit.cover)),
                  ),
                  ListTile(
                    title: Text(value.favoriteBlogs[index].title),
                    trailing: FavoriteButton(blog: value.favoriteBlogs[index]),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
