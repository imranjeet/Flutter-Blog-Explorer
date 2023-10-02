import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer_app/models/blog_model.dart';
import 'package:blog_explorer_app/widgets/favorite_button.dart';
import 'package:blog_explorer_app/screens/detailed_blog_view.dart';
import 'package:blog_explorer_app/providers/blog_data_provider.dart';

import 'favorite_blogs_screen.dart';

class BlogListView extends StatelessWidget {
  const BlogListView({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Blog List'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteBlogsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.favorite)),
          )
        ],
      ),
      body: FutureBuilder<List<Blog>>(
        future: blogProvider.fetchBlogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == []) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<Blog> blogs = snapshot.data ?? [];
            // print("blogs: $blogs");
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(blogs[index].title),
                      leading: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            // color: Colors.transparent,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    blogs[index].imageUrl),
                                fit: BoxFit.cover)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailedBlogView(blog: blogs[index]),
                          ),
                        );
                      },
                      trailing: FavoriteButton(blog: blogs[index]),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Blog Explorer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Favorite Blogs'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteBlogsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Navigate to Item 2
              },
            ),
          ],
        ),
      ),
    );
  }
}
