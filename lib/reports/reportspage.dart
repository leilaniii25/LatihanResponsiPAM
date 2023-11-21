import 'package:flutter/material.dart';
import 'package:latihanresponsipam/api_data_source.dart';
import 'package:latihanresponsipam/reports/reportsdetail.dart';
import 'package:latihanresponsipam/reports/reportsmodel.dart';


class PageListReports extends StatefulWidget {
  const PageListReports({Key? key}) : super(key: key);

  @override
  State<PageListReports> createState() => _PageListReportsState();
}

class _PageListReportsState extends State<PageListReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REPORTS LIST"),
        centerTitle: true,
      ),
      body: _buildListReportsBody(),
    );
  }

  Widget _buildListReportsBody() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: ApiDataSource.instance.loadReports(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Report reports = Report.fromJson(snapshot.data);
            return _buildSuccessSection(reports);
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

  Widget _buildSuccessSection(Report data) {
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
                    builder: (context) => PageDetailReports(report: data.results![index]),
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