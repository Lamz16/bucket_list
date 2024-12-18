import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bucket List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : bucketListData.isEmpty
              ? Center(
                  child: Text('No data found'),
                )
              : ListView.builder(
                  itemCount: bucketListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          bucketListData[index]['item'] ?? "unknown resources"),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              bucketListData[index]['image'] ?? "Default")),
                      trailing: Text(
                          "\$ ${bucketListData[index]['cost'].toString()}"),
                    );
                  }),
    );
  }

  String baseUrl = "https://bclist12-default-rtdb.firebaseio.com/";
  List<dynamic> bucketListData = [];

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get("$baseUrl/bucketlist.json");

      setState(() {
        bucketListData = response.data;
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Cannot get data, because $e"),
            );
          });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
