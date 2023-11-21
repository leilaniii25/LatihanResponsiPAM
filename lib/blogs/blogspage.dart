import 'package:flutter/material.dart';
import 'package:latihanresponsipam/api_data_source.dart';
import 'package:latihanresponsipam/blogs/blogsdetail.dart';
import 'package:latihanresponsipam/blogs/blogsmodel.dart';


class PageListBlogs extends StatefulWidget {
  const PageListBlogs({Key? key}) : super(key: key);

  @override
  State<PageListBlogs> createState() => _PageListBlogsState();
}

class _PageListBlogsState extends State<PageListBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOGS LIST"),
        centerTitle: true,
      ),
      body: _buildListBlogsBody(),
    );
  }

  Widget _buildListBlogsBody() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: ApiDataSource.instance.loadBlogs(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Blog blogs = Blog.fromJson(snapshot.data);
            return _buildSuccessSection(blogs);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildSuccessSection(Blog data) {
    return ListView.builder(
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageDetailBlogs(blog: data.results![index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        data.results![index].imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.results![index].title!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}