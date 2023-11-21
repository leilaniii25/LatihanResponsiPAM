import 'package:flutter/material.dart';
import 'package:latihanresponsipam/blogs/blogspage.dart';
import 'package:latihanresponsipam/news/newspage.dart';
import 'package:latihanresponsipam/reports/reportspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPACE FLIGHT NEWS',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('SPACE FLIGHT NEWS'),
          centerTitle: true,  // Judul akan berada di tengah
        ),
        body: MenuPage(),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final List<Menu> menus = [
    Menu('News', 'asset/news.png', 'Get an overview of the latest Spaceflight news, from various sources! Easily link your users to the right websites', PageListNews()),
    Menu('Blog', 'asset/blog.png', 'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast', PageListBlogs()),
    Menu('Reports', 'asset/reports.png', 'Access detailed reports and analyses', PageListReports()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPACE FLIGHT NEWS'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: menus.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin:  EdgeInsets.only(left: 10.0, right: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200.0,
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => menus[index].page,
                          ),
                        );
                      },
                      title: Text(
                        menus[index].name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Ganti warna teks sesuai keinginan
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          menus[index].description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45, // Ganti warna teks sesuai keinginan
                          ),
                        ),
                      ),
                      leading: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage(menus[index].imagePath),

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



class DetailPage extends StatelessWidget {
  final Menu menu;

  DetailPage({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: menu.name,
              child: Image.asset(
                menu.imagePath,
                width: 80,
                height: 80,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Detail Page for ${menu.name}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}





class Menu {
  final String name;
  final String imagePath;
  final String description;
  final Widget page;

  Menu(this.name, this.imagePath, this.description, this.page);
}