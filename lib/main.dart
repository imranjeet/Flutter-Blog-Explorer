import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer_app/screens/blog_list_view.dart';
import 'package:blog_explorer_app/providers/blog_data_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BlogDataProvider(),
      child: MaterialApp(
        title: 'Blog Explorer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BlogListView(),
      ),
    );
  }
}
