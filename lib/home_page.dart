import 'package:flutter/material.dart';
import 'package:practice/services/service.dart';
import 'model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataBaseService _dataBaseService = DataBaseService.instance;

  String? _task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/bg main d.png'),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Todo's",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        floatingActionButton: _addTaskButton(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _tasksList(),
        ),
      ),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text("Add Task"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _task = value;
                          });
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "What are you thinking about?"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Text('Back')),
                          ElevatedButton(
                            onPressed: () {
                              if (_task == null || _task == "") return;
                              _dataBaseService.addTask(_task!);
                              setState(() {
                                _task = null;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Done"),
                          ),
                        ],
                      )
                    ],
                  ),
                ));
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _tasksList() {
    return FutureBuilder(
        future: _dataBaseService.getTask(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Task task = snapshot.data![index];
                return ListTile(
                  onLongPress: () {
                    _dataBaseService.deleteTask(task.id);
                    setState(() {});
                  },
                  title: Text(task.content,style: const TextStyle(color: Colors.white),),
                  trailing: Checkbox(
                    activeColor: Colors.blue,
                    side: WidgetStateBorderSide.resolveWith((states)=>const BorderSide(width: 2,color: Colors.white)),
                      value: task.status == 1,
                      onChanged: (value) {
                        _dataBaseService.updateTaskStatus(
                            task.id, value == true ? 1 : 0);

                        setState(() {});
                      }),
                );
              });
        });
  }
}
