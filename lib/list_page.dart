import 'package:first_test_4/description_page.dart';
import 'package:first_test_4/list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  final String email;
  ListPage(this.email);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListModel()..getTaskList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('評価List'),
          backgroundColor: Colors.teal,
        ),
        body: Consumer<ListModel>(
          builder: (context, model, child) {
            final taskList = model.taskList;
            model.email = widget.email;
            return ListView(
                children: taskList
                    .map(
                      (task) => Card(
                        color: Colors.white60,
                        child: ListTile(
                          title: Text(
                            task.taskName,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DescriptionPage(task.taskName, task.taskID, model.email),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                    .toList());
          },
        ),
      ),
    );
  }
}
