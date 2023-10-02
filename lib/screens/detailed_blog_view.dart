import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:blog_explorer_app/models/blog_model.dart';
import 'package:blog_explorer_app/widgets/favorite_button.dart';

class DetailedBlogView extends StatelessWidget {
  final Blog blog;

  const DetailedBlogView({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Detailed Blog'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.network(blog.imageUrl),
            Container(
              height: 300,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  // color: Colors.transparent,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(blog.imageUrl),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                blog.title,
                style:
                    const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
            // Display other details of the blog
            // ...
            FavoriteButton(blog: blog),
          ],
        ),
      ),
    );
  }
}
