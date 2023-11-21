import 'package:flutter/material.dart';
import 'package:latihanresponsipam/blogs/blogsmodel.dart';
import 'package:url_launcher/url_launcher.dart';



class PageDetailBlogs extends StatelessWidget {
  final Results blog;

  const PageDetailBlogs({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOGS DETAIL"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              blog.imageUrl ?? '',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              blog.title ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              blog.summary ?? '',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchURL(blog.imageUrl ?? '');
        },
        icon: Icon(Icons.image_search_outlined),
        label: Text("See More"),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}