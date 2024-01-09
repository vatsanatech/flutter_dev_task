import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:csv/csv.dart';

class UserNamesTab extends StatefulWidget {
  const UserNamesTab({super.key});

  @override
  _UserNamesTabState createState() => _UserNamesTabState();
}

class _UserNamesTabState extends State<UserNamesTab> {
  List<List<dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      Response<String> response = await Dio().get(
        'https://raw.githubusercontent.com/codeforamerica/ohana-api/master/data/sample-csv/contacts.csv',
      );

      String? csvData = response.data;
      List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData, );
      setState(() {
        csvTable.removeAt(0);
        users = csvTable;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Name"), // Assuming the name is in the second column
          subtitle: Text(users[index][14].toString()), // Assuming the email is in the fifth column
        );
      },
    );
  }
}
