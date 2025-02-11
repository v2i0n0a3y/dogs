import 'package:flutter/material.dart';
import 'package:tot/Api/model.dart';
import '../Api/database_helper.dart';

class OfflineDogsPage extends StatefulWidget {
  @override
  _OfflineDogsPageState createState() => _OfflineDogsPageState();
}

class _OfflineDogsPageState extends State<OfflineDogsPage> {
  List<DogModel> offlineDogs = [];

  @override
  void initState() {
    super.initState();
    _fetchOfflineDogs();
  }

  Future<void> _fetchOfflineDogs() async {
    final dogs = await DatabaseHelper.instance.getDogs();
    setState(() {
      offlineDogs = dogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved Dogs")),
      body: offlineDogs.isEmpty
          ? Center(child: Text("No saved dogs"))
          : ListView.builder(
        itemCount: offlineDogs.length,
        itemBuilder: (context, index) {
          var item = offlineDogs[index];
          return ListTile(
            leading: Image.network(item.imageUrl.toString(), width: 50, height: 50, fit: BoxFit.cover),
            title: Text(item.title.toString()),
            subtitle: Text(item.breed.toString()),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                //await DatabaseHelper.instance.deleteDog(item.id!);
                _fetchOfflineDogs();
              },
            ),
          );
        },
      ),
    );
  }
}
